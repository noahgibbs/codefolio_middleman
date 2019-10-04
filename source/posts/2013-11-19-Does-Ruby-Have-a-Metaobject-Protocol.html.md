---
title: "Does Ruby Have a Metaobject Protocol?"
date: 2013-11-19 04:58
disqus_id: "http://codefol.io/posts/57"
---
There's a semi-famous book, <a href="http://en.wikipedia.org/wiki/The_Art_of_the_Metaobject_Protocol">The Art of the Metaobject Protocol</a> by Kiczales, des Rivieres and Bobrow. Alan Kay, the guy who invented SmallTalk and the phrase "Object Oriented", called it the best book in ten years.

But it's takes some describing.

## What is a Metaobject Protocol?

You know how Ruby has a class called "Class"? And how all classes are instances of it? And how Class is a subclass of Module?

The Metaobject protocol asks, "what if there were *more* subclasses of Class? And you could make classes from them, instead of plain old Class?"

Also, it includes what we'd now call introspection functions -- they didn't usually call it that twenty years ago when this was published.

But what, specifically, does that mean?
<!-- more -->
It includes:

* introspection on classes, methods and instances
* runtime definition of classes, methods and instances
* specialized initializers -- constructors, effectively
* subclasses of "Class" with special behavior, called Metaclasses
* hooks for computing the class precedence list, for things like variable definition and what methods are called when parent classes conflict

Most of this doesn't look too surprising. Clearly Ruby already has a lot of it.

How much of it?

## Ruby Equivalents for Metaobject Protocol Hooks

Ruby already lets you do some really interesting things with your classes <a href="http://codefol.io/posts/What-Hooks-does-Ruby-have-for-Metaprogramming-">using hooks, as you metaprogrammers already know</a>.

In Ruby, instead of a metaclass, you would make a subclass of Object that defined some hooks, and then classes that inherit from that class would get that behavior. Ruby's inherited and method_defined hooks, for instance, are very similar to redefining the inheritance or method definition behavior in a metaclass.

But the Metaobject protocol lets you do a few things with classes that Ruby doesn't (easily).

It defines a hook for "the class is all done being defined" ("finalize-inheritance") -- Ruby never prevents you from including modules or defining methods, so it has no such callback. It's never "final."

The Metaobject protocol lets you say "here is the order to look through parent classes when defining variables and what method gets called." That's not impossible in Ruby, but you'd have to do a lot of undefining and redefining in your classes -- it's clearly not easy.

The other big things that the Metaobject Protocol allows are mostly about generic functions, a very powerful Lisp construct that Ruby has no equivalent for. While we could debate whether Ruby should allow generic functions, it doesn't... And so there's no equivalents for them.

## So... Does Ruby Have One, Or Not?

Ruby doesn't let you create a subclass of Class -- try it in irb!

So in the simple, literal sense it definitely does not.

And it doesn't easily let you calculate a class precedence list, so it's missing at least one major piece of functionality from the Lisp Metaobject Protocol...

But amusingly, you could absolutely write a gem for that! You'd implement all the inheritance and method_definition hooks and then calculate the method precedence as soon as somebody called a function...

So Ruby has nearly all the power of a Metaobject protocol, except for a lack of generic functions. Which could also be written as a gem (I'm <b>so</b> getting flamed for this).

