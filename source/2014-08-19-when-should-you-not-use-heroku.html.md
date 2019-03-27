---
title: "When Should You Not Use Heroku?"
date: 2014-08-19 19:00
---
First off, let’s just say: Heroku is awesome. There are all kinds
of great reasons to use it, and I would never, never claim that
Heroku is wrong for all deployments.

But it’s also not <b>right</b> for all deployments. Let’s talk about
when it's wrong and when it's right.

<img class="pull-right" src="/images/no_heroku/easy_button.jpg" width="182" height="142" alt="Easy mode!" />

Heroku’s big advantages are:

* really easy to deploy
* really easy to scale
* mostly everything just works

Those are big advantages. Sometimes they're <i>the most important
thing</i> for your project.
When they are, you should absolutely use Heroku.

But why might you not?

## It’s Expensive

First, the elephant in the room: the cost. Heroku gives you limited
free hours per month, and after that it’s expensive. Background
threads or processes also cost extra.

A single minimum-power dyno runs you
<a href="https://www.heroku.com/pricing">$36 per month</a>, assuming you
need barely any space in Postgres. Heroku is basically going to
cost you at least twice what a VPS would cost (e.g. Linode or Digital Ocean)
and give you much less power. If you process many
simultaneous requests or run many background threads, it will be
at least three or four times as expensive for the same power.

For a powerful server you're actually using, it's easy to pay $250/mo for what Amazon might have
delivered for $100/mo or Digital Ocean for $80/mo.

<!-- more -->

Third-party services like MySQL (vs Postgres), Cassandra, Redis or
MemCacheD will also cost more if you use them.

## Third-Party Services

<img class="pull-right" src="/images/no_heroku/heroku_addons.png" width="268" height="152" alt="Heroku Add-Ons" />

Speaking of third-party services, they’re not always available.
Somebody has to have written a specific
<a href="https://addons.heroku.com/">Heroku plugin</a> for them,
and you’d better hope the version available matches your needs.

For off-the-shelf services, that’s no problem. Redis or MemCacheD,
for instance, are pretty easy to use.

But if you want Ventrilo or Akka or a specific version or a
specific background process of your own that you’d have to compile…
Nope. Heroku’s not the right service in that case, even if you’re
willing to pay a lot.

## Customization

In general, Heroku limits your ability to customize. You can have
the Ruby versions and third-party libraries (e.g. libxml, node.js,
libuv) that they specifically provide. Need something weird or
a specific version? Sorry, not on Heroku.

Compatibility with app servers is also spotty. They provide Thin
for EventMachine, but there are slightly odd limits as a result
of the Heroku architecture, and it generally won’t work quite
right. Which isn’t a problem if you use Unicorn (now Puma), of course.
Heroku is great *if* you want pre-chosen off-the-shelf components.
Which often you do, and occasionally you don’t.

Similarly, the Ruby evented support (e.g. EventMachine) isn’t
amazing. That’s not a problem for you… Unless it is.

<img src="/images/no_heroku/event_machine.jpg" width="300" height="131" alt="EventMachine Logo" />

## Architecture

The Heroku architecture is great if you're building a hosting service, and a
little weird if you’re being hosted on it.

Your app needs to be prepared to be killed and put onto a new server at any
time, instantly. That means you can’t write to local disk (no log files, no
file-based Rails cache), nor assume that things like global variables will
last from request to request.

You can do some Heroku-specific logging, but you have to do it
all in a very specific style.

Your app serves its own static content, which can be slow -- especially in
Rails. It also means Heroku silently inserts gem(s) (e.g. <a href="https://github.com/heroku/rails_serve_static_assets">rails_serve_static_assets</a>) to make your app
behave the way they want. And it can cause problems. The reason they changed
from Unicorn to Puma was because Unicorn has significant denial-of-service
problems without a reverse proxy, for instance.

It also means that a lot of your existing operations knowledge
doesn’t work. You can’t log into the machine and poke around,
and you certainly can’t modify machine settings or have your
application save local state or logs.

Is that a problem? Well, sometimes.

## Et Al

<img class="pull-left" src="/images/no_heroku/huge_cpu.jpg" width="252" height="189" alt="A Huge CPU" />

Heroku is also hard to use for non-web services that don't use HTTP. It’s not
really set up for them.

It gets your data, which may or may not be a problem. It’s
like other cloud vendors, but may not be okay for you.

And Heroku’s scaling of dynos — regular, 2x everything
or huge CPU and RAM for 16x the cost — may not be for
you. Or it may be fine, depending.

## Do I Use Heroku? The Short Version

You’ve read (or skimmed or scrolled) through the long
version.

What’s the short version?

The short version is that when you have an installation
where you don’t need to customize much, and you don’t
need a lot of servers, Heroku is great.

Or when you want utter simplicity and being expensive is fine,
Heroku is awesome. Especially if somebody
else pays the server bill!
