---
title: "Rejected by GoGaRuCo: Mocking Time.now for Faster Tests!"
date: 2012-08-08 03:45
disqus_id: "http://codefol.io/posts/23"
tags: ruby
---
I proposed a talk for the Golden Gate Ruby Conference, and got turned down. Usually that's it, but the excellent and classy Josh Susser offered to say why he'd turned people down (woot!). He said:

I think we had a good idea of what your talk would be about. But this year we are a bit tired of testing focused talks, and we were also skeptical that your talk would have a half hour of content.

Wow! Josh Susser, Leah Silber and Jim Meyer told me I couldn't be enough of a blowhard to talk about mocking Time.now for 30 minutes?

<img src="/images/23/challenge_accepted.jpeg"
  alt="challenge accepted" />

It'll take me more than one blog post, though! Expect this to be a series. A 30-minute talk's worth of content would be quite a long post...

To start with:

## Two-Week Tests in Thirty Seconds: Mocking Time.now and Threads

If you have sleeps or loops that check time in your library and you want to test that, it can take awhile. Let's see an example:

``` ruby
# mylib.rb
class MyLib
  def bar
    # No-op
  end

  def maybe_update
    t = Time.now
    if !@last_check || (t - @last_check > 10)
      @last_check = t
      do_something
    end
  end
end
```

This would normally take 10 seconds before it will call do_something again. That can make it hard to call it in consecutive tests, or to test that its update logic is working. Enter the magic of mocha and mocking:

``` ruby
# test_mylib.rb
require "./mylib"
require "test/unit"
require "mocha"

class TestMyLib < Test::Unit::TestCase
  def setup
    @obj ||= MyLib.new
  end

  def test_maybe_update
    @obj.expects(:do_something)
    @obj.maybe_update
  end

  def test_still_update_if_bar_happens
    @obj.expects(:do_something)
    @obj.bar
    @obj.maybe_update
  end
end
```

This test fails if you run both, even though it's fine if you run just one. It *looks* like calling bar, a no-op, makes maybe_update fail, even though it doesn't. Problems like these can be real head-scratchers, especially if the two tests are in different files. "Hey, this test worked fine on my machine but it's failing on the build machine!" No. You were running just that one file on your machine, and the build machine runs everything.

Let's see how mocking Time.now can fix this:

``` ruby
require "./mylib"
require "test/unit"
require "mocha"

# test_mylib.rb
class TestMyLib < Test::Unit::TestCase
  def setup
    @obj = MyLib.new
    @t ||= Time.now
    @t += 30
    Time.stubs(:now).returns(@t)
  end

  def test_maybe_update
    @obj.expects(:do_something)
    @obj.maybe_update
  end

  def test_still_update_if_bar_happens
    @obj.expects(:do_something)
    @obj.bar
    @obj.maybe_update
  end
end
```

This works! Test::Unit calls setup before each test and we mock Time.now to return 30 seconds later each time so that the 10-second check is fooled. This is *way* better than sleeping ten seconds before the second test. You'd be depressed to know how many people solve the problem that way and forever after their test suites run slowly.

Now think about a test that can run longer. The hacks around it are often horrible. Mocking Time.now isn't beautiful, but it's not awful.

Now you know the basics. In a few days I'll have another post for you with another use of this technique, and then we'll move on to how to use it in threaded situations -- a quite common reason to need to mock Time.now.

