---
title: "Rails Is the Wrong Tool for Your REST API"
date: 2012-12-31 14:25
disqus_id: "http://codefol.io/posts/34"
---
Rails is a heavyweight framework and it does <a href="http://guides.rubyonrails.org/security.html">a lot of awesome stuff by default</a> that only a few other frameworks provide. But most of the benefit goes <i>right</i> out the window when you’re using it to write a simple REST API. Lemme ‘splain.

## What’s In a REST API?

When I say “your REST API”, I’m specifically talking about a little application server that serves requests over HTTP, preferably using <a href="http://en.wikipedia.org/wiki/Representational_state_transfer">REST principles</a>, but not necessarily. Generally a REST API server is backed by a database or other form of data storage. It might provide calculation of some kind, either with a data store or not. You can think of the Twitter API or the GitHub API, for instance, or simpler things like <a href="http://graphite.readthedocs.org/en/1.0/url-api.html">querying data points from Graphite</a>.

What I am <i>not</i> talking about is anything serving a user-visible HTML-CSS-and-JS web site, meant to be consumed by a user, interactively, in a browser. Let’s call that a “web app server” instead of a “REST API server”.

Rails should be used for web apps in most cases, and REST APIs only rarely.

## Why Not?

Rails is <i>heavy</i>. Installing Rails on a fresh system requires installing the following gems, at minimum:

~~~
Successfully installed i18n-0.6.1
Successfully installed multi_json-1.5.0
Successfully installed activesupport-3.2.9
Successfully installed builder-3.0.4
Successfully installed activemodel-3.2.9
Successfully installed rack-1.4.1
Successfully installed rack-cache-1.2
Successfully installed rack-test-0.6.2
Successfully installed journey-1.0.4
Successfully installed hike-1.2.1
Successfully installed tilt-1.3.3
Successfully installed sprockets-2.2.2
Successfully installed erubis-2.7.0
Successfully installed actionpack-3.2.9
Successfully installed arel-3.0.2
Successfully installed tzinfo-0.3.35
Successfully installed activerecord-3.2.9
Successfully installed activeresource-3.2.9
Successfully installed mime-types-1.19
Successfully installed polyglot-0.3.3
Successfully installed treetop-1.4.12
Successfully installed mail-2.4.4
Successfully installed actionmailer-3.2.9
Successfully installed rack-ssl-1.3.2
Successfully installed thor-0.16.0
Successfully installed json-1.7.6
Successfully installed rdoc-3.12
Successfully installed railties-3.2.9
Successfully installed rails-3.2.9
29 gems installed
~~~

(Plus Bundler and Rake, not shown)

And it’s not just the 31 gems. A fresh clean Rails app (“rails new myapp”) has 37 directories, takes 164kb, has 18 .rb files, hard-codes how to do things for three different app environments and has a frightening amount of configuration.

It’s hard to specifically measure how many API entry points Rails has (do all those automatic ActiveRecord accessors count? Does the controller/view interface count?), but at least several hundred methods.

Rails is wonderful, but it’s <i>heavy</i>. It requires a lot of code, a lot of structure in your application, and a lot of mental overhead to keep track of. How long did it take you to learn Rails? How much of it do you know? And <i>how</i> big is “The Rails 3 Way”?

<img src="http://blog.obiefernandez.com/.a/6a00e54fdca91188330147e1cb9591970b-pi"> </img>

## The Alternatives

Here’s another way to judge whether Rails is a high-overhead choice for a REST API. Compare it to <a href="http://sinatrarb.com">Sinatra</a>, where a small API app is one file, and often under 30 lines. Or <a href="http://www.padrinorb.com/">Padrino</a>, which includes the same things but also has database migrations, and it’s still tiny. Or stripped-down specific API choices like <a href="https://github.com/intridea/grape">Grape</a>. Even <a href="https://github.com/filtersquad/rocket_pants">RocketPants</a> -- it’s also built on the ActiveFoo Rails-y libraries... But it doesn’t use Rails because putting together a full Rails app is simply too heavyweight.

The <a href="https://github.com/rails-api/rails-api">Rails-API</a> project exists (and is run by Rails core members!) specifically because vanilla Rails is seen <i>by Rails core members</i> as not being a reasonable choice for APIs. Think about that.

## But It Doesn’t Get In My Way!

The amount of overhead we’re talking about looks small if you’re Twitter-sized. So why does <a href="http://engineering.twitter.com/2011/04/twitter-search-is-now-3x-faster_1656.html">Twitter use Java instead?</a>

Because Rails overhead doesn’t just stop after “rails new” finishes running.

<a href="http://rubyrogues.com/object-oriented-programming-in-rails-with-jim-weirich/">Trying to do even plain-vanilla object-oriented programming in Rails</a> is suddenly a complicated topic with a <a href="http://evan.tiggerpalace.com/articles/2012/11/21/use-rails-until-it-hurts/">lot of people weighing in</a>, sometimes <a href="http://objectsonrails.com/">at book length</a>. You have to educate every new programmer on your project in that several-hundred-entry-point Rails API and how you mix it with OO.

Fundamentally, a dedicated API framework like Grape or Sinatra is just <i>lower overhead</i> to get new people up to speed.

Or, eventually, a company gets big enough to care a lot about per-machine performance and switches to a faster language, as Twitter did with Java. Let’s assume your API server isn’t as big as Twitter’s yet.

## Why You Knocking My Homie Rails?

<a href="http://rebuilding-rails.com">I love Rails, really and truly</a>. I wrote a whole book singing its praises. No kidding. I believe that a small team putting together a user-facing web site should use Rails because no other framework comes <i>remotely close</i>. Rails is versatile, powerful, flexible and lets you change direction on a dime.

And for that team's API server, when they have a separate one, that team should use Sinatra. Or Grape. Or even <a href="http://rack.github.com">just plain Rack</a>.

Also, if they build their framework in Rack directly, they should <a href="http://rebuilding-rails.com">buy my book</a> because the basic Rack docs aren’t great -- it’s better to walk through building a full framework if you want to understand it.

