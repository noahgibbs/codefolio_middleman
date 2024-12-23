---
title: "Rails Internals on Codefol.io"
layout: horace_page
comments: false
mc_signup: rails
next: false
prev: false
---

<img src="/images/codefolio_book_transparent_320_205.png#right" width="320" height="205" alt="The Codefol.io logo on a book cover."> </img>

I have fun blog posts about Ruby on Rails, a book about them and many other recommendations. Here's a lot of my favourite material on that subject.

Rails Basics and Rails Internals:

* [Understanding the Structure of Rails](/posts/Understanding-the-Structure-of-Rails/) - an introductory post about how Rails is structured - the large gems that make up Rails
* [Where Do I Put My Code in Rails? (updated)](/posts/where-do-i-put-my-code-in-rails-updated/) - my opinions about where to put various kinds of code in the Rails directory structure
* I spoke in 2013 at Golden Gate Ruby Conference about [The Littlest ORM](https://www.youtube.com/watch?v=Uh5MYvNXt0A) - basically the ORM chapter of Rebuilding Rails, turned into its own short talk
* [What is Rack?](/posts/What-is-Rack-A-Primer/) - understand the basics of what Rack actually is
* [No More Requires](/posts/No-More-Requires/) - how Rails skips requires in most cases, and how you can do the same thing via const_missing
* [Digging Into the Rails Source](/posts/Digging-Into-the-Rails-Source/) - where to start
* [Rack and Session Store](/posts/Rack-and-Session-Store/) - a quick intro/answer to "how does Rack/Rails store session data?"
* [Understanding HashWithIndifferentAccess and the Rails Params Hash](/posts/Deep-Rails-Understanding-HashWithIndifferentAccess-Understanding-the-Params-Hash/)
* [How Does Rack Parse Query Params?](/posts/How-Does-Rack-Parse-Query-Params-With-parse-nested-query/)
* [Use Rails Until it Hurts - But Not for APIs](/posts/Use-Rails-Until-It-Hurts-But-Not-for-APIs/) - a bit about when to use Rails, how to use Rails, and when not to
* [Why Rails and Not Sinatra or Node.js?](/posts/Why-Rails-and-not-Sinatra-or-Node-js/) - an older post about Rails' continued advantages... Most of which are still true
* [Rack Authentication Middleware](/posts/Rack-Authentication-Middleware/) - how to use the simple built-in Rack authentication middleware

Larger Projects to Learn Rails:

* A [workshop I gave at Southeast Ruby 2019](https://speakerdeck.com/noahgibbs/build-your-own-framework-to-understand-rails-magic) - similar to, but quite different from, Rebuilding Rails; build a stripped-down minimal MVC framework as fast as possible, roughly
* My book <a href="https://rebuilding-rails.com">Rebuilding Rails</a> is about how to understand Ruby on Rails deeply by building your own Ruby web framework, from blank directories, structured like Rails.
