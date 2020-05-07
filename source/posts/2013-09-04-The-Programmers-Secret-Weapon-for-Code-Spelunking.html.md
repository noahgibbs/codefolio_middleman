---
title: "The Programmer's Secret Weapon for Code Spelunking"
date: 2013-09-04 02:47
disqus_id: "http://codefol.io/posts/52"
tags: tools
---
A lot of the time, it’s hard to find where Ruby has defined something. When you want to know, “what code did that?”, some languages have debugger watchpoints, Java has Eclipse, Ruby has…? What?

Ruby isn’t terribly friendly to IDEs. Dynamic method definition, highly configurable inheritance, libraries like ActiveRecord that reconfigure at runtime… IDEs have a lot of trouble finding the code you want in a highly dynamic language. With great power comes great responsibility. Which often means you’re suddenly on your own.

<a href="http://beyondgrep.com"><img src="/images/52/ack_screen.png#right" style="border: 2px solid black;" /></a>

In Ruby, my go-to solution is command-line code search. I’ve used <a href="http://beyondgrep.com">Ack</a> for many years. While recursive find would take seconds or minutes, Ack would take well under ten seconds, consistently. It’s very fast, recursive, uses Perl-compatible regexps, very fast, lets you search by language, very fast, doesn’t require an IDE or project file and did I mention very fast? I used it constantly until about April.

And then I found Ag ("https://github.com/ggreer/the_silver_searcher"). It is THREE TIMES as fast as Ack. You know that jaw-hits-floor moment? When I first searched for something in a large code tree with Ag… It was <a href="http://www.nngroup.com/articles/response-times-3-important-limits/">faster than fast -- instant</a>. I hit the return key and the output was just there. As fast as the next prompt popped up, so did a page and a half of search results.

<a href="http://www.nngroup.com/articles/response-times-3-important-limits/"><img src="/images/52/usability_screen.png#left" style="border: 2px solid black;" /></a>

When you’re looking for code, stop waiting on anything. Don’t wait on GNU find or your IDE. When you’re used to instant search you’ll have your next query half-composed by the time you hit return on your first one. Searching for code becomes a <a href="http://en.wikipedia.org/wiki/Read%E2%80%93eval%E2%80%93print_loop">Read-Eval-Print Loop</a> like in any good language. Like the <a href="http://en.wikipedia.org/wiki/OODA_loop">OODA loop</a>, you can tighten it up and everything just feels better.

<a href="http://en.wikipedia.org/wiki/OODA_loop"><img src="/images/52/ooda_loop.png#right" style="border: 2`px solid black;" /></a>

Some quick gotchas in Ruby -- often a method is dynamically defined, so you can’t always find it by its name. Sometimes you’re looking for a table and ActiveRecord changes from snake_case to CamelCase. Regexps and case-insensitive search (-i) can really help you out here -- get used to using them.

Sometimes files aren’t searched by default. For instance, Rakefiles and .erb files may not be in Ack’s default idea of Ruby files. You can add an <a href="https://gist.github.com/kevinold/4749656">.ackrc</a> and configure Ack exactly to your liking. That’s one of the better advantages over Ag, in fact. Consider using <i>both</i> of them, especially if you like speed but also need regexps occasionally -- and use a tool like <a href="https://github.com/sampson-chen/sack">Sack</a> to automatically switch between them so you don’t have to remember when to use each.
