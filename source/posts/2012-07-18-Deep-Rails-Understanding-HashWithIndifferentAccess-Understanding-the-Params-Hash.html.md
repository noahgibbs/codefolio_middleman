---
title: "Deep Rails: Understanding HashWithIndifferentAccess, Understanding the Params Hash"
date: 2012-07-18 03:22
disqus_id: "http://codefol.io/posts/11"
tags: rails, rebuildingrails
---
Rails <a href="/posts/How-Does-Rack-Parse-Query-Params-With-parse-nested-query">parameter parsing</a> can be hard to understand, but it goes beyond that.

Just understanding the "params" object in your controller actions is a little tricky. Ever notice how params[:bob] and params["bob"] both work?  The magic type behind that is called HashWithIndifferentAccess. Yeah, it's a mouthful. I wish I were making that up, but no.

There's a lot of interesting code in Rails with interesting Ruby tricks - so let's de-magic the params object, find some bugs with it and <a href="https://rebuilding-rails.com">get better at Ruby</a>, all at once.

<h2> The Source </h2>

I like going straight to the source, so here is <a href="https://github.com/rails/rails/blob/808592bae2b83ced018f16d576d41a0059ed302a/activesupport/lib/active_support/hash_with_indifferent_access.rb">the exact version of the file I'm looking at in ActiveSupport</a>. You can read here or follow along on GitHub.

It's a nice readable 176 lines.

<h2> What's It Do? </h2>

In Rails you can say params["people"] or params[:people], and either way you get the same thing back. Simple enough, right?  Well, mostly.

You can see on <a href="https://github.com/rails/rails/blob/808592bae2b83ced018f16d576d41a0059ed302a/activesupport/lib/active_support/hash_with_indifferent_access.rb#L7">line 7</a> that it inherits from Hash &mdash; Ruby is convenient that way.

The biggest magic is on <a href="https://github.com/rails/rails/blob/808592bae2b83ced018f16d576d41a0059ed302a/activesupport/lib/active_support/hash_with_indifferent_access.rb#L159">line 159</a>, in fact, in convert_key(). It just converts any key it sees to a string.

<a href="https://github.com/rails/rails/blob/808592bae2b83ced018f16d576d41a0059ed302a/activesupport/lib/active_support/hash_with_indifferent_access.rb#L159"><img src="/images/11/line_159.png" alt="listing from line 159" /></a>

So HashWithIndifferentAccess is just a regular hash, but any symbol key is converted to a string. If you put in a key that was, say, nil, nothing would change. It only converts symbols, not NilClass (which is nil's type.)

<h2>Fun Ruby Tricks</h2>

This class shows one fun ruby trick - <a href="https://github.com/rails/rails/blob/master/activesupport/lib/active_support/hash_with_indifferent_access.rb#L49">aliasing and replacing a method</a>. The old hash update and assignment are renamed to regular_update and regular_writer.

<a href="https://github.com/rails/rails/blob/master/activesupport/lib/active_support/hash_with_indifferent_access.rb#L49"><img src="/images/11/line_49.png" alt="listing from line 49" /></a>

You can also see just how many methods you need to override to make your own hash... Default(), brackets, assignment, update(), key(), fetch(), dup(), merge() and many more. Making your own variant type is a bad idea unless you <a href="http://www.ruby-doc.org/core-1.9.3/Hash.html">spend some quality time with the core language documentation</a> and see what actually changes.

But if you do, it can be really useful, like the Rails params object!

<h2> What Can Go Wrong? </h2>

There are some oddities, like stringify_keys! and symbolize_keys! -- what do you do for a HashWithIndifferentAccess?  They do nothing... Fair enough.

But right next to convert_key is convert_value()... And it's <i>interesting</i> - if you assign an array to the hash, you can see that they do a .map! and <i>change the array</i> before assigning it.

That means if you said:

``` ruby
my_array = [ :a, :b, { :c => :d } ]
params[:item] = my_array
```

Your array will actually change!  That hash inside will suddenly have indifferent access and it will point to a whole different object!

(Why?  I spent awhile with git log trying to answer that. Looks like it's <a href="https://github.com/rails/rails/commit/f43e5d160bf9708ad50b58c8168e38579769e024">because just mapping the Array won't give you the right subclass</a>, so they rewrite the innards instead!  <a href="/posts/Unsolvable-Ruby-Problems-Array-map-on-an-Array-subclass-but-keep-the-subclass">Map into an unknown Array subclass is an unsolvable problem in Ruby</a>, actually...)

<h2> Up To Date? </h2>

Nothing stays the same forever. In Rails, not much stays the same for long. So here is a <a href="https://github.com/rails/rails/blob/master/activesupport/lib/active_support/hash_with_indifferent_access.rb">link to the latest HashWithIndifferentAccess in GitHub</a>, whenever you go look for it.

<h2>Enjoy Getting Your Hands Dirty?</h2>

Do you enjoy code spelunking to learn about Ruby metaprogramming and the internals of Rails?  I wrote a book about that. The first couple of chapters are free and awesome -- you can <a href="https://rebuilding-rails.com">download them in exchange for your email address</a>.
