---
title: "Rejected by GoGaRuCo: Mocking Time and Threads, Part 2"
date: 2012-09-04 03:03
disqus_id: "http://codefol.io/posts/26"
tags: ruby
---
This idea was <a href="http://codefol.io/posts/Rejected-by-GoGaRuCo-Mocking-Time-now-for-Faster-Tests">rejected by GoGaRuCo (link to part one)</a> as a talk. So you get to see it on this blog!

Quick summary: I've got a thing with a background thread. Clearly the code could have things go wrong. Oh Jeebus, how do I test it?

You can check out <a href="https://github.com/ooyala/hastur">Hastur's Ruby client</a> as an example here -- it has exactly this problem, but is simple enough to explain easily. So when you ask, "instead of the example code, what should this actually look like?", Hastur isn't a bad place to check. Hastur sets up a background thread automatically to send back a process heartbeat. It has some unit tests to check that, which use some of the techniques in this post.

Here's the much-simplified code we'll test with in this post:

``` ruby
# mylib.rb
class MyLib
  attr_reader :initialized

  def initialize
    @mutex = Mutex.new
    @counter = 0
    start_bg_thread
  end

  def start_bg_thread
    @thread = Thread.new do
      thread_method
    end
  end

  def counter
    @mutex.synchronize do
      @counter
    end
  end

  def counter_inc(increment = 1)
    @mutex.synchronize do
      @counter += increment
    end
  end

  def thread_method
    last_update = Time.now
    @initialized = true
    loop do
      sleep 1
      if Time.now - last_update >= 5
        counter_inc
        last_update = Time.now
      end
    end
  end
end
```

There are actually several techniques for mocking a background thread.  It's a hard thing because it's inherently timing-dependent and stateful, and state and timing are two of the hardest things to test.

What are the options?

### Mock the Thread Completely

One choice is to just never start a background thread. If you have a method that starts the thread, you can mock it. Or you can mock Thread.new just as you mocked Time.new in the last post. Or let the thread run, but don't use it.

You'll need to mock any methods the thread would call or values it would set that affect the main thread.

There's a lot that doesn't get tested that way. Since none of the thread's code ever executes, it could be completely broken and never do anything and you wouldn't know. You've mocked it away completely.

On the plus side, this methods gives the most reliable tests *because* you're not using a big ball of timing and state in your unit tests. The approach is very clean &mdash; so clean that it misses a lot of the problems you'd like to test.

```ruby
# test_mylib.rb
require "./mylib"
require "test/unit"
require "mocha"

class TestThreadsCleanly < Test::Unit::TestCase
  def setup
    @obj ||= MyLib.new
  end

  def test_thread_stuff
    # Test later on when the counter is higher
    @obj.expects(:counter).returns(7)

    assert_equal 7, @obj.counter
  end

end
```

### Mock the Thread Operations

You can also start the thread and mock all the things it *calls*. That tests the thread's code, but tests it in isolation from the larger system.

This is better since the thread code is guaranteed to not be 100% broken. It's not perfect because you're still not testing the interaction of the thread with the rest of the system. But it can be a very useful way to unit test.

You'll also notice a couple of (annoying) sleeps in the test code. To avoid those, you basically need some way for the library background thread and the test code to wait on each other -- that's so rarely a good idea that I'm not even going to go into it. Believe me, you can do it, and if you do then you're probably hardcoding the tests to the point where they don't really test the behavior of code that *doesn't* integrate that deeply.

```ruby
# test_mylib2.rb
require "./mylib"
require "test/unit"
require "mocha"

class TestThreadOperations < Test::Unit::TestCase
  def setup
    @obj ||= MyLib.new
  end

  def test_thread_stuff
    # When we get here, we don't know if the
    # thread operations have actually started.
    # You can wait on an operation or even just
    # sleep(0.1) and be pretty sure.
    sleep 0.1 until @obj.initialized

    # First, the operation to check
    @obj.expects(:counter_inc)

    # Then ensure update will trigger
    t = Time.now + 15
    Time.stubs(:now).returns(t)

    # Now wait again for the sleep to end and
    # the thread to execute
    sleep(2)

    # We never call any explicit operations
    # because we only want to test the thread,
    # not the rest of the system.

    # When you exit, the "expects" on the
    # operation you were waiting for will trigger.
  end

end
```

### The Full Monty

You can also let the system interact properly between thread and non-thread operations. That gives you the largest, most integrated testing while also giving the greatest chance that your test code is getting something subtly wrong. Writing multithreaded code integrating multiple components is hard, and your test is one more component that has to integrate with the thread.

Keep in mind that, at least with Mocha, any method you "expect" doesn't actually get called. So that can wreak havoc if you let it. Try to only "expect" things that are only side effects, or that you can mock away completely. It's hard, and you may have to cheat by calling original methods from test code in some cases.

Also, this should strike you as bigger, slower, more annoying and more brittle than the previous two cases, even in this simple, abstracted example. It is.

When Functional Programming people talk in smug tones about how you should avoid stateful programming because state is the Original Sin of programming and so on and so forth... This is what they're talking about. This is to be avoided where possible. Now all you have to do is use Haskell for everything, right?

Here's the example with the test code:

``` ruby
# test_mylib3.rb
require "./mylib"
require "test/unit"
require "mocha"

class TestThreadOperations < Test::Unit::TestCase
  def setup
    @obj ||= MyLib.new
  end

  def test_thread_stuff
    # Same synchronization problems as last test
    sleep 0.1 until @obj.initialized

    # Get "pre" counter value
    c = @obj.counter

    # Also want to force update, like last test
    t = Time.now + 15
    Time.stubs(:now).returns(t)
    sleep 2

    c2 = @obj.counter

    # Assert that counter ticked up once
    assert_equal c + 1, c2

    # This is actually harder than it looks.
    # What if we had a counter update right
    # after getting c but before stubbing
    # Time.now? We'd get a c2 that was
    # higher by 2, not 1. This test will pass
    # by itself because the timing is pretty
    # reproducible. Run it with something
    # that takes a multiple of 5 seconds, and
    # you'll occasionally hit that bug...
  end
end
```

### What's the Right Answer?

I don't think there *is* a true right answer. When you ask me "unit tests or integration tests?", I think the answer has to be "both". When you ask me "mocking, or isolated testable units?", again I think it has to be "both." You have to test a lot of components whose design you don't control. And in a language with good mocking like Ruby, the overhead of dependency injection is often not worth it. Without it your code is often far more maintainable, and monkeypatching/mocking can effectively give you free dependency injection in most cases. Use it when it's worth the maintainability hit.

But getting back to "both"...

Integration tests are far more expensive per bug found than unit tests. But unit tests will never find interaction bugs between components. Mocking Time.now and Thread.new is clearly well into "integration test" territory. Don't replace unit tests with it, that's stupid. Use unit tests to check your individual components, including the thread itself. Then write integration tests that don't test each component all that much, but that are designed to test how each component *talks* to each other component.

It's expensive in time and effort, and often unpredictable. But it will catch bugs that no amount of unit testing will ever catch.
