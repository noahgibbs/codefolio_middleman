---
title: "Good Resources for Learning DevOps as a Developer?"
date: 2015-10-20 05:16
---

I've gotten this question several times in several forms, so here's a typical one, and my current answer...

<blockquote>I'm a mid level Rails engineer with strengths in Ruby,
Rails and TDD. I understand OOP and REST, but I am relatively week
when it comes to deploying a Rails application. Do you recommend any
resources on learning how to deploy a Rails app, grow/maintain its
deployed environment, and optimize for your application's performance
and scaling abilities?</blockquote>

In general, not really. This turns out to be a gaping hole in the landscape.

Part of the problem is that there's not one standard way to do this,
and the methods change constantly. You can find tutorials and
(sometimes) books on specific, individual tools like Chef, Ansible,
Capistrano, Docker and so on, but they're terrible about providing an
overview. You have to already have a good idea of what the top level
looks like, which is difficult given that the tools make different
assumptions and are for different scenarios, but don't spell that out.

You can see an example of one way to set it up in my <a href="https://github.com/noahgibbs/madscience">Ruby Mad Science
open-source software</a>, but
please don't purchase <a href="http://rails-deploy-in-an-hour.com">the associated class</a>. I'm in the process of
winding it down.

For pretty much the same reason, it turns out. Deployment is something
everybody currently does custom. It's possible that a Rails-style
entrant (and/or Rails itself) will eventually standardize this enough
to allow one flavor of deployment instead of thousands or millions of
flavors, but we're absolutely not there yet. Heroku is the current
closest.

Certainly look at Heroku if you haven't already. It's the only example
of a simple standard method of deployment, and it's the gold standard
for "it just works." It's also <a href="http://codefol.io/posts/when-should-you-not-use-heroku">expensive and not very configurable</a>,
but it's still worth looking at.

Right now, people go out and learn by doing, with highly variable results :-(
