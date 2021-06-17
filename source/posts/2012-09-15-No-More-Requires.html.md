---
title: "No More Requires"
date: 2012-09-15 22:31
disqus_id: "http://codefol.io/posts/32"
tags: rails, rebuildingrails
---
I hate all the “requires” at the front of Ruby files. I *know* what methods I'm using, but I have to write it in both places. Not exactly <a href="http://en.wikipedia.org/wiki/Don't_repeat_yourself">DRY</a>. Rails skips them &mdash; you just use the classes you want. How can I automatically load my files like Rails does? Read on.

Ruby has method_missing. When you call a method that doesn’t exist on an object, Ruby tries calling “method_missing” instead. That lets you make “invisible” methods with unusual names.

Ruby also has const_missing, which does the same thing for constants that don’t exist. Class names in Ruby are just constants. Hmm...

## const_missing and You

First, let’s see how const_missing works.
Put this into a file called test_const_missing.rb and run it:

``` ruby
# test_const_missing.rb
class Object
  def self.const_missing(c)
    STDERR.puts "Missing constant: #{c.inspect}!"
  end
end

Bobo
```

When you run it, you should see “Missing constant: :Bobo”. So we get to the constant, but it’s not loaded. That seems promising. But we still get an error.

Create a file in the same directory called bobo.rb that looks like this:

``` ruby
# bobo.rb
class Bobo
  def print_bobo
    puts "Bobo!"
  end
end
```

Pretty simple. Let’s change the first file:

``` ruby
# test_const_missing.rb
class Object
  def self.const_missing(c)
    require "./bobo"
    Bobo
  end
end

Bobo.new.print_bobo
```

Now try running it again. It prints Bobo! as you’d hope. So we just need to return something from const_missing, and that’s what the unloaded constant acts like.

Hey, that’s exactly what Rails does!

## CamelCase and snake_case

There’s one hitch, though. When you use a constant like BadAppleController, it’s not loading a file named BadAppleController.rb. It’s loading bad\_apple\_controller.rb. So we’ll need to convert from one to the other.

<a href="http://en.wikipedia.org/wiki/CamelCase">CamelCase</a> is the name for alternating capital and lowercase letters to show where words begin and end. The other way is called <a href="http://en.wikipedia.org/wiki/Snake_case">snake\_case</a> when you use lowercase\_and\_underscores.

Since we know we need to do that conversion, let’s add a method to do it.

``` ruby
# to_underscore.rb
def to_underscore(string)
  string.gsub(/::/, '/').
  gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
  gsub(/([a-z\d])([A-Z])/,'\1_\2').
  tr("-", "_").
  downcase
end
```

I stole and lightly modified this from ActiveSupport in Rails. I’m not going to explain it here (<a href="http://rebuilding-rails.com">I do in my book</a>).

## Putting It Together

You have all the pieces. You can catch a class not existing. You can convert a class name to a filename. You already know the rest -- it's basic. So let’s add automagic constant loading.

Open up test_const_missing.rb:

``` ruby
# Okay, one more require...
require "to_underscore"

# test_const_missing.rb
class Object
  def self.const_missing(c)
    require to_underscore(c.to_s)
    Object.const_get(c)
  end
end

Bobo.new.print_bobo
```

You've just written code to see that the class is used and load it up automatically. Now you just need to figure out where from...

But I'll leave that as an <a href="http://catb.org/jargon/html/E/exercise--left-as-an.html">exercise for the reader</a>.

## And That's That...?

Did you enjoy this? It's pretty much straight from the book I'm writing. If you give me your email address below, you'll get the chapters leading up to it about building a Ruby web framework... And now you know how to make that framework load constants automatically!
