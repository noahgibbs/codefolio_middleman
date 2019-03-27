---
title: "What Hooks does Ruby have for Metaprogramming?"
date: 2013-11-19 05:43
disqus_id: "http://codefol.io/posts/58"
---
Ruby lets you hook in and see (and change!) a lot of behavior of the core language. Methods, constants, classes, variables... Ruby lets you query them all, and change a lot about them.

These are just hooks -- things Ruby calls in response to something happening. That's different from, say, all the methods you can call to find our what's defined and how -- like instance variables, or method bindings, or...

Here's summaries and links for all the hooks I could find (thanks to Google and StackOverflow!):

<!-- more -->

## Methods

<ul>
  <li><a href="http://robots.thoughtbot.com/always-define-respond-to-missing-when-overriding">respond_to_missing?: a way to make sure your dynamic methods defined with method_missing also handle respond_to? correctly</a></li>
  <li><a href="http://ruby-doc.org/core-2.0.0/BasicObject.html#method-i-method_missing">method_missing: called when a method cannot be found, potentially to allow dynamically defining one instead</a></li>
  <li><a href="http://ruby-doc.org/core-2.0.0/Module.html#method-i-method_added">method_added: called whenever a method is added... which can be used to modify the method</a></li>
  <li><a href="http://ruby-doc.org/core-2.0.0/Module.html#method-i-method_removed">method_removed: called whenever a method is removed</a></li>
  <li><a href="http://www.ruby-doc.org/core-1.9.3/BasicObject.html#method-i-singleton_method_added">singleton_method_added: method added to the singleton class of the object, to be callable just on this one instance</a></li>
  <li><a href="http://www.ruby-doc.org/core-1.9.3/BasicObject.html#method-i-singleton_method_removed">singleton_method_removed: method removed from singleton class</a></li>
  <li><a href="http://ruby-doc.org/core-2.0.0/Module.html#method-i-method_undefined">method_undefined: a method has been undefined, with undef_method.</a> Undef_method is different from remove_method because remove_method may still allow superclasses to define the method -- undef_method means it's gone entirely.</li>
  <a href="http://www.ruby-doc.org/core-1.9.3/BasicObject.html#method-i-singleton_method_undefined">singleton_method_undefined: called when a singleton method is undefined entirely</a></li>
  <li>initialize_copy: an optional callback when cloning any Object</li>
</ul>

## Classes

<ul>
  <li><a href="http://www.ruby-doc.org/core-2.0.0/Class.html#method-i-inherited">inherited: a Ruby class is subclassed</a></li>
</ul>

## Modules

<ul>
  <li><a href="http://www.ruby-doc.org/core-2.0.0/Module.html#method-i-append_features">append_features: a Module is included, and its constants, methods and variables used</a></li>
  <li><a href="http://ruby-doc.org/core-2.0.0/Module.html#method-i-included">included: a Module is included</a>, which usually obsoletes "append_features"</li>
  <li><a href="http://ruby-doc.org/core-2.0.0/Module.html#method-i-extend_object">extend_object: a Module extends an Object</a></li>
  <li><a href="http://ruby-doc.org/core-2.0.0/Module.html#method-i-extended">extended: an Object is extended by a module</a>, which mostly obsoletes extend_object</li>
  <li><a href="http://ruby-doc.org/core-2.0.0/Module.html#method-i-const_missing">const_missing: a constant isn't already present</a></li>
</ul>

## Marshalling

<ul>
  <li><a href="http://ruby-doc.org/core-2.0.0/Marshal.html">marshal_dump: called on an object to have it dump itself in Ruby Marshal format</a></li>
  <li><a href="http://ruby-doc.org/core-2.0.0/Marshal.html">marshal_load: called on an object to have it load itself in Ruby Mashal format</a></li>
</ul>

## Coercion

<ul>
  <li><a href="http://stackoverflow.com/questions/2799571/in-ruby-how-does-coerce-actually-work">coerce: called by the first type in a two-argument operator on the second argument, to make it turn into something the first argument can recognize</a></li>
  <li>induced_from: deprecated, please don't use</li>
  <li>to_i, to_f, to_s, to_a, to_hash, to_proc and others: conversions, indicating that the object is being used as a type and should try to convert itself to that type</li> 
</ul>
