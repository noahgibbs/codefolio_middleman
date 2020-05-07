---
title: "Web Servers and Application Servers"
date: 2013-08-11 16:06
disqus_id: "http://codefol.io/posts/50"
tags: rails, rack, deployment
---
A reader recently asked me why Ruby web app deploys usually have a web server (NGinX, Apache) <i>and</i> an application server (Unicorn, Thin, Puma, Racer, Mongrel, Passenger, Jakarta, TorqueBox or whatever I've forgotten this week).

Actually, he asked, "why do I need to run NGinX <i>and</i> Unicorn?" It's a fair question.

### My Answer

In some sense you don't need it. It's 100% possible to just run Unicorn for your site. The main reasons to run a web server as a reverse proxy (NGinX or Apache):

* Speed. Both of those servers handle static requests *much* faster than any Ruby app server. They're designed for it.

* Configurability. NGinX and Apache have many options related to security, SSL, rewriting URLs and request queueing with no equivalent in the app server. They also have an easier time running multiple different sites at once (example: running five subdomains with three different Ruby versions) for similar reasons.

* Stability. The web servers fail more rarely and gracefully, partly because they have a *much* larger audience than all Ruby app servers together.

* Support. If you need to add an option (example: fair round-robin request queueing), it's much easier to find a plugin for NGinX or Apache.

With that said, when you have a small simple site, you can totally run it off Unicorn and call it a day. You won't have as many configuration options available. You'll have more trouble with SSL support. You'll serve fewer requests (static ones for CSS, JS, etc. add up). You'll have slightly more downtime. But for small sites, you may not care about any of that.

Note that Passenger is a weird hybrid here. It's a Ruby app server, but it bakes in a copy of NGinX. So it's much closer to running with NGinX *and* an app server than Unicorn or Thin.
