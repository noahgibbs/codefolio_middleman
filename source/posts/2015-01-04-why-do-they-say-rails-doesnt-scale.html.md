---
title: "Why Do They Say Rails Doesn't Scale?"
date: 2015-01-04 19:27
tags: rails, business
---

If you're new to Ruby on Rails, you may be new to the old debates (pro and con) about how <a href="https://www.quora.com/Does-Ruby-on-Rails-scale-Why-or-why-not#">"Rails doesn't scale."</a> You might wonder why people say that, or where it came from.

<img src="/images/rails_noscale.png#right" width="200" height="385" alt="The Rails logo and a scale with a circle-and-slash over top." />

Let's talk about that.

As far as "Rails Doesn't Scale", the main arguments go something like:

## 1) Ruby is slow, often up to 50x slower than C, so the server will eventually collapse.

This isn't actually a scaling argument. But it's true that Ruby is slow. Not 50x any more, closer to 5x (up to maybe 20x), but still, that's not terribly speedy.

Rails doesn't help Ruby here. A lot of the metaprogramming techniques it uses are among the slowest things Ruby does. I wrote a book about how Rails uses those techniques called <a ref="http://rebuilding-rails.com">Rebuilding Rails</a>. They're awesome, but they're not speedy.

In practice, Ruby and Rails apps often "farm out" the slow stuff. The database is the traditional place to put the heavy lifting, but you'll see Redis and Cassandra used in similar ways. Want Ruby to be fast? Call to something that isn't Ruby, and is designed for speed :-)

Pure Ruby <b>is</b> quite slow, but just as scalable as any other language or library. It doesn't get somehow slower as you add more.

## 2) Ruby/Rails leaks resources, so large or long-running projects don't work

There was once more truth to this. Ruby had a few leaks and Rails exercised Ruby like nothing else. Also, ActiveRecord encourages large amounts of garbage per request, which was <a href="https://www.quora.com/Does-Ruby-on-Rails-scale-Why-or-why-not#">easy to mistake for leaks</a>.

READMORE

Early Rails apps were shamefully likely to set a max requests/process threshold as low as 100 requests, often plus a memory watchdog to kill large processes, to deal with this problem. In other words, individual worker processes of the Rails site would be killed after a certain number of requests or a certain size in MB to clear out old leaks.

These days most of the leaks are gone, but you can still bloat processes with poor use of ActiveRecord pretty easily. It's something you have to watch for, and the debugging tools aren't what they should be. Except in JRuby, of course &mdash; JRuby can use the standard JVM memory debugging tools, which are pretty good.

## 3) Rails isn't stable enough, look how bad big Rails sites are!

Twitter did a lot to ruin Rails' reputation here. But it also did a huge amount <i>for</i> Rails' reputation and <a href="http://www.slideshare.net/Blaine/scaling-twitter">shared their scaling tips</a> so I'm not really complaining.

Twitter used a back-end that was almost wholly unlike "normal" web apps, and it caused all kinds of weirdness. Rails was great for prototyping the Twitter UI, but not so good for the back end. That makes sense - Rails is a web library, it's not really designed for back ends. But mostly they were doing something new and custom, and it crashed a fair bit.

This argument ignores that the <b>other</b> huge Rails site at the time was Penny Arcade. Which did nothing weird or custom, and ran with basically no crashes ever at extremely high traffic.

Twitter <i>did</i> take a long time to get stable. But that's because it was (for the time) a ridiculously write-intensive workload, plus read patterns that worked very poorly with sharding or B-tree indices. It was a pathological case for relational databases, and that made it hard to get right.

Which, you'll note, is a completely Rails-irrelevant problem. Rails neither helped nor hurt it.

These days we'd use NoSQL for that. For instance, DataStax Cassandra training has a twitter clone as one of their first examples. But Twitter started early enough that NoSQL wasn't really an option.

## 4) Rails is okay for little brochure sites, but its structure doesn't work for large codebases.

This is the closest to a true argument, but still pretty irrelevant. Let's call it a bit of a cultural divide.

Java has a strong tradition of huge monolithic apps. Having a web framework that causes in-process problems for back ends (memory leaks, bloat, process restarts) is really bad. It's bad because you often don't separate your front end process from your back end process. In Java, managing lots of small processes is often hard. Java is a terrible glue language.

In Ruby, it's really easy. Ruby is a great glue language. Ruby and Rails aren't great for data storage back ends, but they call out to them like a champ. So: you can have transient, bloaty front end processes but not have to restart your back-end servers because they're not the same processes. Eventually they're not even on the
same machine, of course.

Twitter eventually solved this, both in Java and Ruby, the right way. They separated front end servers from back end servers, divvied up lots more small services, scaled Rails and then eventually replaced Rails.

Which is, for the record, a really good call. Rails is great for prototyping. But when you have a huge project where you want Swiss-watch accuracy and long-term backward compatibility, it's time to move on to a more rigid framework.

You can also solve this in Rails. Here are some folks that talk about how to adapt the Rails great-for-a-front-end structure to a larger great-for-a-big-codebase structure:

* <a href="http://objectsonrails.com/">Objects on Rails</a>, a book by Avdi Grimm
* <a href="http://www.poodr.com/">Practical Object Oriented Design in Ruby</a>, a book by Sandi Metz
* A variety of conference talks, often on <a href="http://confreaks.com">ConFreaks</a>, such as <a href="http://www.windycityrails.org/videos/2013/#8">this one</a>.
* <a href="https://www.agileplannerapp.com/blog/building-agile-planner/refactoring-with-hexagonal-rails">Hexagonal Rails</a>, exemplified by this blog post
* Jim Gay's <a href="http://clean-ruby.com/">Clean Ruby</a> and his <a href="http://saturnflyer.com">blog</a> often address this

So you don't have to abandon Rails for really big apps, but you often want to stop using the default Rails app structure.

### History and So On

There's not a lot to the arguments. Rails attracted a lot of resentment by getting popular fast, and that always makes for silly accusations. But it's nice to know the history of such things, and it's nice to know where the real problems may lie.

I hope this helps you out!
