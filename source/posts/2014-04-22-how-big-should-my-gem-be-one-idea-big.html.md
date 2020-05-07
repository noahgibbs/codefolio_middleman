---
title: "How Big Should My Gem Be? One Idea Big."
date: 2014-04-22 22:02
tags: ruby
---

<img src="/images/one_idea/sapphire.jpeg#right" alt="A large sapphire" />

If you've never built a Ruby gem, go do that first. It's amazingly
easy. And it lets other people use your stuff!

When you do you'll have to figure out -- how much goes into one gem?
What should you cut up into new gems?

<b>Here's how you tell.</b>

## What's the Big Idea?

You want your gem to have one basic idea. Then, cut out everything
that isn't part of that idea. If your gem solves differential
equations... Great! Don't expose methods for memory allocation just
because you wrote them.

The people who download your gem are busy, and they have short
attention spans.

So you get to tell them one thing. What's that one thing?

## Aren't Gems Inefficient?

People from other languages make fun of five-line gems. Ruby people
usually know better.

A Ruby gem can do amazing things in five lines -- single ideas that
don't take more than that can be <i>awesome</i>.

If you're using 20 kilobytes to package up five lines of text...
<b>Dude!</b> It's 20 kilobytes. You waste more than that in TCP
headers checking gmail <b>every five minutes</b>.

Gems are cheap. I promise.

Helping people see your amazing idea is priceless. Don't shovel in
hundreds of lines of crap so it seems "more serious." Just show off
the important part.

<img src="/images/one_idea/email_headers.jpeg" alt="electronic message headers" />

## How Big is Too Big?

<img src="/images/one_idea/gems_labeled.jpeg#right" alt="pictures of gemstones" />

There are <a href="http://sourcemaking.com/antipatterns/the-blob">many</a>
<a href="http://lostechies.com/chrismissal/2009/05/28/anti-patterns-and-worst-practices-monster-objects/">explanations</a>
<a href="http://en.wikipedia.org/wiki/God_object">of the</a>
<a href="">problems</a> with God Objects,
a.k.a. Monster Objects -- objects that do too much and know too much.

Libraries can have the same problem.

A library that knows too much is giving you orders. RSpec includes
its own mocking library... And so it's hostile to people who like <a
href="http://github.com/rr/rr">RR (Ruby Double)</a> or <a
href="https://github.com/freerange/mocha">Mocha</a>. It forces you to
do things its way. Is that why you started programming Ruby?

As much as I love <a
href="http://guides.rubyonrails.org/active_support_core_extensions.html">ActiveSupport</a>,
it does the same thing. It requires very specific versions. It
monkeypatches the core libraries. It's just not friendly to people who
want to do their own thing.

In the end, this is like "one idea" up above... If you force your
users to do it your way, they'll hate your gem. Show them something
awesome and they'll love it.

## But I Want Numbers!

I can't give you a maximum number of lines for your gem. But here are
some rough ideas:

<a
href="http://api.rubyonrails.org/classes/ActiveRecord/Base.html">ActiveRecord</a>
is about 30,000 lines... And it's a <b>huge</b> gem. If you're
writing more Ruby than this in one go, you'd better have a really good
reason. And its largest file (associations.rb) is still only around
1500 lines. That's a <b>lot</b> of Ruby code.

<a href="https://github.com/benprew/pony">Pony</a> is a fabulously
useful email gem, which mostly wraps another, worse email gem. It's
only 500 lines, and half of that is tests. I <b>do not care</b> that
it's "too small." I care that it works well and the interface is
<b>awesome</b>. If it were only 10 lines, I would still use it
happily.

The important thing, for both of them is: <b>the gem has one central
idea, and it stays true to it.</b>

You should do the same.
