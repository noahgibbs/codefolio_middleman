---
title: "Unsolvable Ruby Problems: Array#map on an Array subclass, but keep the subclass!"
date: 2012-07-18 03:48
disqus_id: "http://codefol.io/posts/13"
tags: ruby
---
I love looking at problems with "no solution" in languages to stretch my mind.  Here's a fun one from Ruby.

In Ruby, there's not a good way to map over a <i>subclass</i> of Array and get the same subclass back.

That is, if you start with this code:

``` ruby
class Array
  def but_doubled
    map { |x| x * 2 }
  end
end
```

This will work fine on an Array, but if you call my_array_sub_object.but_doubled, you'll get a plain Array, not a subclass object.

<h2>Yes There Is, You Meanie!</h2>

You may think, "sure, no problem.  Just re-define #map on the subclass to return the subclass."  Ah, but then you don't get to choose whether to return the subclass or Array.  Plus, if the author of the subclass didn't do that you can't do it...  Or you have to monkeypatch.  This <i>is</i> Ruby.

But if you don't know what subclass you might be passed, you have a problem.  <a href="http://codefol.io/posts/Deep-Rails-Understanding-HashWithIndifferentAccess-Understanding-the-Params-Hash">That happens sometimes, even in code like Rails</a>, and then the <a href="https://github.com/rails/rails/commit/f43e5d160bf9708ad50b58c8168e38579769e024">solutions aren't always pretty</a>.

<h2>Make a New One</h2>

You could create a new object of that subclass and then add the objects back into that.  That works, right?  Well, sometimes.

If you don't know the subclass, you don't know what initialize() takes as parameters.  You can hope that it's the same as Array, but it often isn't...

Indeed, you don't have to ask long before people start telling you to <a href="https://groups.google.com/forum/?fromgroups#!topic/ruby-talk-google/stvr3xzIStU">avoid this entirely and rethink your whole approach</a>.

<h2>Then... What?</h2>

I don't have a perfect answer -- nor does Rails, as you saw above.

But after thinking of several ways to solve the problem and coming up with a few of your own, do you now know more about Ruby?

Basically I mostly just like <a href="http://rebuilding-rails.com">messing around in the guts of Ruby</a>. Do you?

What things are impossible in <i>your</i> favorite language?  What are your favorite half-solutions?
