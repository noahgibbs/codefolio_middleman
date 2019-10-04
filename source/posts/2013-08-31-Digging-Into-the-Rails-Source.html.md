---
title: "Digging Into the Rails Source"
date: 2013-08-31 23:37
disqus_id: "http://codefol.io/posts/51"
---
You’ve made it mostway through your free Ruby on Rails Internals class. Today we’ll be poking around the Rails source code. If you have money but not time, Rebuilding Rails lets you find a lot quickly… But in case you have more time, we’ll see where in the Rails source you can learn the same things for yourself.

First off, Rails has a combination of terse, pithy code (easy to read!) and good, solid tests which help explain what a given piece of code <i>does</i>. I recommend switching back and forth between implementation and tests often when reading.

Head to <a href="http://github.com/rails/rails">Rails on GitHub</a>. My screenshots are branch 3.2-stable, or you can look at latest. You can already see the division into gems with the various directories: actionmailer, actionpack, activemodel, activerecord, activeresource and activesupport.

<img src="/images/51/github_screen.png" width="956" height="657" />

You can see the controller and view code in “actionpack” (note: <a href="https://github.com/rails/rails/tree/master/actionview">actionview has been extracted</a> in Rails 4). Rebuilding Rails has an easy simplified version, but you can see the real thing in there with some work. <a href="https://github.com/rails/rails/tree/master/actionpack/lib">Inside actionpack/lib are subdirectories</a> like action_controller which provide a great start for a deep dive.

<h2> Rack </h2>

Later chapters of Rebuilding Rails talk a lot about Rack, including Rack Middleware. For that, you should look at http://github.com/rack/rack instead of Rails. Luckily, most of the Rack code you care about is quite short. Unluckily, it’s poorly documented. Again, make sure to read tests (where they exist) for best understanding. I don’t know another introduction as good as Chapter 8 of Rebuilding Rails, but you can get some of the same content from a <a href="http://www.youtube.com/watch?v=evDJMLb1d28&feature=youtu.be">my Ruby Hangout interview on Rack frameworks</a>.

<img src="/images/51/rack_screen.png" width="805" height="571" />

<h2> Dependencies </h2>

Rails also depends on a number of other libraries. It’s hard to understand ActiveRecord without <a href="https://github.com/rails/arel">Arel</a>, for instance. Read through the <a href="https://github.com/rails/rails/blob/master/rails.gemspec">.gemspec</a> <a href="https://github.com/rails/rails/blob/master/activesupport/activesupport.gemspec">files</a> when you want to know what Rails depends on. That’s also great when thinking, “huh, what else should I add to my own framework?” If you don’t know what a gem does, Google something like <b>“arel gem”</b> or <b>“tzinfo gem”</b> or <b>“ruby mail gem”</b>. You can also check out rubygems.org to track down info and documentation if you know its name.

In general, look at dependencies like Gemfile and .gemspec files for every library you look at. You can learn a <i>lot</i> about any library from what gems it uses.

<h2> Get the Code Locally </h2>

GitHub is a nice interface and all, but it’s no substitute for having the code locally where you can use it. Make sure to clone the code for the things you care about, and “bundle install” the dependencies you won’t be drilling into yet. If you use a Ruby IDE like RubyMine that may help. We’ll talk about what I use for exploration in the next lesson.

<h2> And Now, a Word From... </h2>

Incidentally - if you prefer the guided tour, considering buying Rebuilding Rails for your workplace. Companies pay more for your time than just your salary -- Rebuilding Rails is probably a good investment if it saves you just half an hour.

Will it, though? Start with the free chapters, and see if anything in there could save you ten minutes. Or just buy it, and if you’re not delighted, I’ll refund your money.
