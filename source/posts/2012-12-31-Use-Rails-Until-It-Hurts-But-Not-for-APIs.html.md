---
title: "Use Rails Until It Hurts - But Not for APIs"
date: 2012-12-31 05:35
disqus_id: "http://codefol.io/posts/33"
---
Evan Light recently used the wonderful phrase <a href="http://evan.tiggerpalace.com/articles/2012/11/21/use-rails-until-it-hurts/">”Use Rails Until It Hurts”</a>. He meant that Rails has built-in mechanisms for organizing your code and objects, and they usually result in simpler, cleaner code that mixing Rails with non-Rails.

I say your <i>startup</i> should use Rails until it hurts. And it hurts most to use it for APIs. Let me tell you what I mean.

## Rails and Less Rails

I work at <a href="http://ooyala.com">Ooyala</a>, an awesome mid-sized startup. Like many startups, we <a href="http://engineering.twitter.com/2011/04/twitter-search-is-now-3x-faster_1656.html">started on Rails and we’re using less and less Rails as we go along</a>. We’re switching mostly to Sinatra and other Ruby frameworks, for the record.

Rails is designed for defaults. Rails is <i>amazing</i> for your tiny startup that’s just testing out an idea. And Rails’ <a href="http://guides.rubyonrails.org/security.html">wonderful ways to protect you from yourself</a> will take you a surprisingly long way without making you think too hard about security. That’s great... up to a point.

But we all know that <a href="/posts/Rails-Is-the-Wrong-Tool-for-Your-REST-API/">vanilla Rails isn’t so good for APIs</a>. A big company’s <a href="http://en.wikipedia.org/wiki/Service-oriented_architecture">internal code is pretty much a giant ball of APIs</a>. And internal code is <a href="http://research.google.com/pubs/papers.html">95% of what we do</a>. Even <a href="http://twitter.com">companies who clearly love Rails</a> stop using it for back-end APIs pretty quickly. And that’s even better.

## Wait, Switch? To What?

Why? What’s better for APIs? Well, <a href="http://www.slideshare.net/oisin/simple-rest-services-with-sinatra">Sinatra</a>, pretty obviously. <a href="https://github.com/spastorino/rails-api">Rails-API</a>, when it’s finally stable. And in fact, there’s a burgeoning cottage industry of API frameworks just in Ruby, including <a href="https://github.com/intridea/grape">Grape</a> and <a href="https://github.com/filtersquad/rocket_pants">RocketPants</a>.

For that matter, you can build on plain vanilla <a href="http://rack.github.com/">Rack</a> -- if you do, consider <a href="http://rebuilding-rails.com">buying my book</a> since it’s the best documentation on how to build a low-level Rack framework.

## But Then, Is Rails Doomed?

I keep saying “Rails is awesome” in kind of back-handed ways. So let me say, for the record: I think Rails is great, I think it’s still growing, and I think it’s not going away. I think that <a href="http://ruby.dzone.com/articles/rails-vs-grails">even more frameworks are going to steal its best ideas</a>. I think it’s going to take a long time to be replaced, and whatever finally kills it doesn’t exist yet.

I think it’s going to become clearer that Rails is a niche framework for a very specific set of needs. And I think it’s <i>by far the best thing out there</i> for that niche and those needs. And I think we’re going to see a lot more <a href="http://engineering.twitter.com/2011/04/twitter-search-is-now-3x-faster_1656.html">“growing out of Rails”</a> stories and a lot more “growing out of Rails” frameworks as we see “Rails” and “post-Rails” as two different viable niches.
