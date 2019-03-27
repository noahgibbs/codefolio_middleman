---
title: "Why Rails and not Sinatra or Node.js?"
date: 2012-09-05 02:48
disqus_id: "http://codefol.io/posts/29"
---
Rails is <a href="http://www.engineyard.com/blog/2009/thats-not-a-memory-leak-its-bloat/">bloated</a> and <a href="http://gilesbowkett.blogspot.com/2012/02/rails-went-off-rails-why-im-rebuilding.html">hard to learn</a>. You'd love to use a really simple framework like Sinatra. But what if you need something from Rails that isn't there?  You can't memorize all the hundreds of helper methods in Rails. But what are the important ones that will hurt you badly if you don't know them?

Why not build from something simpler and smaller?  <a href="http://nodejs.org">Node.js</a> or <a href="http://sinatrarb.com">Sinatra</a>, say?

How much useful can Rails give you that's <a href="http://www.quora.com/Has-Ruby-on-Rails-became-bloated">worth all the bloat</a>?

Some good stuff, actually... But less than you think.

### Security

The big answer is "security". I won't go over <a href="http://guides.rubyonrails.org/security.html">the entire list of security stuff you should care about for Rails</a>. But here are some highlights that you'll need to fix if you build on <a href="http://rebuilding-rails.com">a slimmer framework</a> before you put it up online:

* <a href="http://guides.rubyonrails.org/security.html#session-fixation-countermeasures">Session fixation and hijacking</a>
* <a href="http://guides.rubyonrails.org/security.html#csrf-countermeasures">Cross-Site Request Forgery</a>
* <a href="http://guides.rubyonrails.org/security.html#countermeasures">Mass Assignment</a>
* <a href="http://guides.rubyonrails.org/security.html#sql-injection-countermeasures">SQL Injection</a>
* <a href="http://guides.rubyonrails.org/security.html#html-injection-countermeasures">Cross-Site Scripting and HTML Injection</a>

Rails has fixes for all of these linked in the list. <a href="http://guides.rubyonrails.org/security.html">Check the Rails security guide</a> for more information about what this buys you.

The Rails security guide also covers a lot of problems you have to know in *any* web framework.

Do you care?  You really, *really* should.

### Assets

Rails will happily precompile your <a href="http://coffeescript.org">CoffeeScript</a>, use <a href="https://github.com/sstephenson/sprockets">Sprockets</a> to compress your JavaScript, add <a href="http://jquery.com">jQuery</a> to your app and <a href="http://guides.rubyonrails.org/asset_pipeline.html">generally get things ready for you</a>.

But perhaps more importantly, it will rename your assets (images, CSS, javascript, etc) every time they change and fetch them at a slightly different address. This means that in development mode you get to skip a *lot* of cache bugs when you change files.

Rails will also do a few other things to your assets like auto-sprite-ify sets of images with CSS and serve your assets from several different asset subdomains for maximum speed.

Do you care?   You probably care after you're scaling up significantly. Rails will give you these things for free, which is nice. Or your framework of choice will allow you to build it manually and then debug it.

### Optimization

Rails makes it easy to do things like <a href="http://guides.rubyonrails.org/caching_with_rails.html">page, action and fragment caching<a/> backed by files, memory, MemCacheD or in several other ways.

It also has good support for things like <a href="http://www.tbray.org/ongoing/When/200x/2008/08/14/Rails-ETags">ETags</a> and <a href="http://stackoverflow.com/questions/11145447/rails-3-http-header-if-modified-since-using-curl">If-Modified-Since</a> via helpers like <a href="http://stackoverflow.com/questions/3744090/rails-fresh-when-stale-usage">fresh-when and stale?</a>.

That's probably the kind of thing you're happy to ignore when you pick a slimmer framework.

### Libraries

Rails has a head start over everybody else in libraries. Sinatra can <a href="http://codefol.io/posts/What-is-Rack-A-Primer">run Rack middleware</a> and Node.js has an extensive library accessible through NPM, but Rails has <a href="http://ruby-toolbox.com">an unparalleled selection of libraries that support it</a>.

Basically *everything* Ruby supports Rails.

Some of the best stuff is Rack, and so it supports Rails *and* Sinatra. But often even if you're using Rack middleware, there's an additional wrapper with convenience functions for Rails, so Rails has the advantage again. For instance, <a href="https://github.com/hassox/warden">Warden</a> is a nice Rack-based authentication system, but <a href="https://github.com/plataformatec/devise">Devise</a> is the same thing nicely packaged for Rails.

### Now Go Build in Whatever You Like

I'm not worried whether you use Rails, Sinatra, Node.js, <a href="http://padrinorb.com">Padrino</a>, <a href="http://rebuilding-rails.com">Rulers</a> or something else completely.

But remember that a web app with bad security can compromise everybody *else's* security too. When you pick a smaller, simpler framework, know what you're missing and how to fix it.

Play safe!
