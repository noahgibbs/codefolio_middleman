---
title: "Ruby Miscellaneous on Codefol.io"
layout: horace_page
mc_signup: rails
comments: false
next: false
prev: false
---

<img src="/images/codefolio_book_transparent_320_205.png#right" width="320" height="205" alt="The Codefol.io logo on a book cover."> </img>

Some Ruby topics that don't fit into a more specific category. Some of these articles are mine, posted to engineering.appfolio.com from my time as their Ruby fellow.

Ruby Internals:

* [How Ruby Encodes References: Tiny Objects Explained](http://engineering.appfolio.com/appfolio-engineering/2019/6/25/how-ruby-encodes-references-ruby-tiny-objects-explained)
* [Ruby and Nested Exceptions](http://engineering.appfolio.com/appfolio-engineering/2017/12/28/ruby-and-nested-exceptions) - Newer Ruby allows nested exceptions in a useful and powerful way; not everything uses them yet, though
* [Using git bisect to Find a Ruby Regression](http://engineering.appfolio.com/appfolio-engineering/2016/6/7/git-bisect-to-find-a-ruby-regression) - tracking a bug in the Ruby interpreter? Git's built-in tooling can help!

Social and Community:

* [How is Ruby Different in Japan?](http://engineering.appfolio.com/appfolio-engineering/2017/5/24/how-is-ruby-different-in-japan) - I was surprised at how different usage of Ruby was in Japan, so I wrote about it (thanks to Zach Scott who helped a lot with this!)
* [CRuby, MRI, JRuby, RubySpec, Rubinius, YARV - A Little Bit of Ruby Naming](http://engineering.appfolio.com/appfolio-engineering/2017/12/28/cruby-mri-jruby-rubyspec-rubinius-yarv-a-little-bit-of-ruby-naming) - wonder what various names mean in the Ruby community? A bit of a glossary
* [A Ruby Troll Story](/posts/a-ruby-troll-story/) - a short fun story about a troll coming after Sarah Mei, and an older, less-fun story about what trolls have stolen from our community
* [Why Do They Say Rails Doesn't Scale?](/posts/why-do-they-say-rails-doesnt-scale/) - a historical perspective for the young'uns; please don't be the next person to read only the headline and come after me for what you assume every later line says.
* [Ruby and Haskell: Culture is What You Don't Say](http://engineering.appfolio.com/appfolio-engineering/2018/4/23/ruby-haskell-culture-is-what-you-dont-say) - a fun compare/contrast between languages after I worked through the Purple Book to understand Monads properly
* [RubyConf Malaysia and Getting the Most from a Distant Conference](http://engineering.appfolio.com/appfolio-engineering/2018/11/2/rubyconf-malaysia-and-getting-the-most-from-a-distant-conference)
* [Diving Into Japanese for Ruby](http://engineering.appfolio.com/appfolio-engineering/2016/10/14/diving-into-japanese-for-ruby) - for working on the Ruby core language, it can be useful to pick up a little Japanese; here's how I did
* [Why Ruby Should Stay a Laughingstock] - Ruby takes a big hit on geek credibility to stay useful to businesspeople - it's worth it for you to know the specifics
* [The Ruby Community is a Loud, Bright, Wonderful Mess](/posts/The-Ruby-Community-is-a-Loud-Bright-Wonderful-Mess/)

Technical:

* [Ruby, RubyGems and Bundler](http://engineering.appfolio.com/appfolio-engineering/2017/2/27/ruby-rubygems-and-bundler) - an explanation of these three different layers of Ruby gem handling
* [The Programmer's Secret Weapon for Code Spelunking](/posts/The-Programmers-Secret-Weapon-for-Code-Spelunking/) - find everything without trusting your IDE!
* [How Big Should My Gem Be? One Idea Big](/posts/how-big-should-my-gem-be-one-idea-big/) - a simple (but not easy!) rule for scoping your Ruby gems
* [Does ActionCable Smell Like Rails?](http://engineering.appfolio.com/appfolio-engineering/2018/8/6/does-actioncable-smell-like-rails) - an evaluation of the ActionCable API
* [What Hooks Does Ruby Have for Metaprogramming?](/posts/What-Hooks-does-Ruby-have-for-Metaprogramming/) - an overview of what bits the CRuby interpreter lets you hook into
* [Multiple Gemfiles, Multiple Ruby Versions, One Rails Version](http://engineering.appfolio.com/appfolio-engineering/2018/12/10/multiple-gemfiles-multiple-ruby-versions-one-rails-version) - on managing multiple different Gemfiles and Ruby versions for the same app; can be useful in benchmarking
* [Ruby 2.7 and the Compacting Garbage Collector](http://engineering.appfolio.com/appfolio-engineering/2019/3/22/ruby-27-and-the-compacting-garbage-collector) - an explanation of Ruby 2.7+ and some important changes to its garbage collector for (eventual) speedups
* [Threads in Ruby](/posts/threads-in-ruby/) - a simple how-to with video
* [Web Servers and Application Servers](/posts/Web-Servers-and-Application-Servers/) - what are all these things we run to run Rails?
* [Timing Attacks are Really Tricky](/posts/Timing-Attacks-Are-Really-Tricky/) - not really about Ruby, but about just how incredibly difficult it is to fully mitigate timing attacks

War Stories and Debugging Stories:

* [A Story of Passion and Hash Tables](http://engineering.appfolio.com/appfolio-engineering/2017/6/11/a-story-of-engineering-passion-and-ruby-hash-tables) - two Russian geniuses play Dueling Banjos to get their own Hash implementation into Ruby Core
* [Wait! Why is system() Returning the Wrong Answer?](http://engineering.appfolio.com/appfolio-engineering/2019/5/20/wait-why-is-system-returning-the-wrong-answer-a-ruby-debugging-story)
* [A Tale of Two Objects Part One: Rake Does WHAT?](http://engineering.appfolio.com/appfolio-engineering/2018/8/8/a-tale-of-two-objects) - written with Mischa Lewis-Norelle
* [A Tale of Two Objects Part Two: Ruby's main Object does WHAT?](http://engineering.appfolio.com/appfolio-engineering/2018/8/9/rubys-main-object-does-what)
* [To Sleep, Perchance to Dream](http://engineering.appfolio.com/appfolio-engineering/2018/5/4/mf0io5nsvdcbp5kzjvkfczsfdyshaf) - why SleepyGC, a plausible Ruby feature, was no help at all to Rails Ruby Bench
