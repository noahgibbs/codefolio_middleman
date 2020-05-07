---
title: "Why I Shut Down Rails-Deploy-In-An-Hour"
date: 2016-01-28 18:42
tags: entrepreneur
---

Some of you may remember Rails Deploy In An Hour,
a Ruby deployment class I tried selling last year. More of you
probably remember <a href="http://rubymadscience.com">Ruby Mad
Science</a>, the open-source software that went with it.

I'm not selling the class any more, though I haven't taken down
Ruby Mad Science, and I don't intend to. But it won't be getting the
maintenance it would want... now that I understand just how much that
is.

I wondered, "why aren't there more good Ruby deployment products out
there?" And "why don't people know more about the books there already
are?" And as I learned more I started to wonder, "why aren't there
more Heroku competitors?" And "why did Ninefold stop supporting
Rails?"

These are interesting questions. I know the answers better now, and
I'm happy to share them. Perhaps they'll help the next person fix the
problem better than I did.

## What People Want

It turns out that programmers hate doing deployment. The programmers
I'm targeting (hobbyists, early developers, small startup guys)
extra-specially hate doing deployment. They just want it done and
working with minimal work.

READMORE

This is still a pipe dream, it turns out. My software helps a bit, but
not enough. Let's talk about why.

### Why the Technical Side Fails

All the components of your server, including the OS, the system
libraries, your web framework, your database, other storage
(MemCacheD, Redis, etc.), your work queue, your app itself and any
other little utilities (process manager, log rotator, monitoring, web
server, app server) are gonna fight. Individually, any two of them are
more-or-less compatible.

But you know that exercise where they say "each component of the space
shuttle is 99% reliable and there are 1000 components, how reliable is
it?" (*Answer: 0.0043% chance it works*) And that exercise where you
calculate the number of relationships between N components? You wind
up with O(N^2) relationships that are each, like, 95% reliable, and
the end result falls over and dies.

I knew all of this and I still wrote Ruby Mad Science. I did it by
saying I was gonna lock down everything. And to be fair, I nearly did.
It's *hard* to lock down, say, the version of Chef that Vagrant uses,
plus all its cookbooks, plus their packages, plus... Yeah. You should
be grateful for the Bundler. For anything in Ruby it's really easy. If
the rest of the world followed suit, this problem might be tractable.

Here's where we fail: the OS. There is no equivalent of Gemfile.lock
for Ubuntu packages, despite a number of ugly attempts to hack it
together. There's just no easy way to do it. Here's what depends on
the OS: everything.

(Real outfits with an Ops group handle this by keeping a local mirror
of some version of Ubuntu they've tested out so that nothing gets
quietly upgraded while they're not looking. It's possible, but not
pretty, and completely inappropriate for my customers to have to do.)

Also, if you somehow succeed then your security is hosed. You know all
those OpenSSL bugs that come out? If you upgrade for them, you have to
test everything again. It's really, really ugly. If you don't upgrade
for them, well, then everybody using your software is 100% vulnerable
to those bugs. Also ugly.

So: that's why this is seriously high-maintenance for me and still
doesn't work well enough for you.

If I got this working, though, it turns out there's another problem.
I think I could have eventually solved the technical problem. But the
next problem? Not so much.

### Why the People Side Fails

Remember how I said developers hate doing deployment? My mental model
of this was "people hate doing deployment, so they'll use my software
as a quick start, get it working well enough with a fixed set of
tools, and rarely think about it again. As long as it works,
everybody's happy."

This model turns out to be flawed.

First: people hate being told what tools to use. I can say "you'll be
using Chef, MySQL, Unicorn, and Capistrano." People respond, "eh,
maybe if you support Postgres and Ansible."

This is, of course, perfectly normal and reasonable. Right now people
have a menu of *hundreds* of these tools, and they want to use the
five they know the interface for. I should know this -- why do you
think I picked the menu I did? They were the ones I knew best.

I can tell people where to debug, a comprehensive list of what errors
you can hit, where you add package names and how to turn on various
software with third-party modules... But if programmers are going to
have to debug things, they want to debug things they like.

It can work so well there's nothing to debug. But you can't (mostly)
tell people "you'll be doing these things with tools you don't know
and don't want to."

Won't people learn the new tools? Mostly no. That goes back to the whole
"developers hate doing deployment" thing. If it's going to take as much
effort as learning a new programming language, and they hate it, they're
not going to do it.

That's fair.

## What Do People Use?

If you're technically handy, you can deploy a server yourself, once,
and then hope it never needs updating. This solution is very popular
and very cheap. It has terrible security, but it turns out most people
don't care (yet.) We're hitting the point where this is a really bad
idea even if you're not a serious target, but (weirdly) we didn't get
there years ago. It's starting to happen.

If you can afford an Ops team, the equivalent is to do a deployment
and then maintain it, first manually and then with Puppet or Chef over
time. It works pretty well, but it requires constant maintenance from
people with high salaries. Good for companies, not an option for
hobbyists.

And then there's Heroku or (for the rich) EngineYard. This is what
people actually want: "look, you manage it for me." It turns out that
this is fairly expensive. Heroku makes good money for large
installations, where people stop using them as soon as possible. But
in return they take a big loss on vast numbers of price-sensitive free
hobbyists. This isn't as cushy a business as it looks like, is what
I'm saying.

## Questions

In no particular order...

### But Didn't People Buy It?

A few. But this is clearly not as good a business as, say, continuing
to sell my Ruby on Rails ebook, and that's not a crazy high bar. More
to the point, there was very little *continuing* buying of it. This is
just a hard market. And with this much maintenance, "not as good a
business as selling one specific ebook forever" is a pretty severe
condemnation :-/

### Does This Mean Nobody Will Ever Solve This?

Not at all. Heroku is doing a pretty darn good job with one solution,
and there are various other up-and-coming solutions that are (slowly)
happening. Things are better than they used to be, and I have every
confidence they'll keep getting better. I just don't think it'll
happen overnight. And I don't think my approach will be scalable for
the next guy, either. Prove me wrong! I'd love to use your product if
it works.

### Will Everybody Stop Using Chef?

Nope. This basic approach (config management, orchestration, VMs) is
actually really powerful, including the Docker variation on the same
thing. But right now it's a lot of work. Several important tools are
missing, and several more are clearly not at all usable for this.

If you have a dedicated DevOps team, it's great right now. If you're a
single random developer, it's too much work. But the amount of work
decreases every year. In 5-10 years I expect it would be
workable... Except something else is likely to overturn the whole
current arrangement before then.

So I guess everybody *will* stop using Chef, but not for awhile. All
of the current tools (Chef, Puppet, Ansible, Salt) are early and have
significant warts. I can't be 100% sure one of them won't be the
long-term solution, but not in any of their current form.

### Doesn't Docker Fix All This?

Not really. Docker still has a huge question mark for state of all
kinds &mdash; logfiles, databases, data files, caches. Most vendors
would like you to pay them to handle the stuff involving state, which
is ten kinds of "not the whole answer."

When I say "huge question mark" I mean "what do you do about that?"
Do you migrate it off immediately? To where, a paid third-party
service? How do you make a seamless transition, given how hard SQL
database switchovers are? There are various (early, slightly ugly)
answers, but none that feel like what we'll be doing in 5-10 years.

Docker is powerful. But our workflow about how to *use* it is still
in its infancy.
