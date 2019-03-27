---
title: "What Do You Lose By Not Using Chef?"
date: 2014-11-29 17:29:23
---

It's easy to find <a
href="http://robmclarty.com/blog/how-to-setup-a-production-server-for-rails-4"
target="_blank">posts about how to set up a Rails server</a> manually. There
are a ton of them out there.

It's also easy to put off setting up Chef until later on. After all, how often
are you going to set up a server? Do it manually, then automate when you need
to, right? <a href="http://xkcd.com/1205/" target="_blank">That's the
tradeoff</a>.

Why would you use <a href="http://www.getchef.com" target="_blank">Chef</a> before you had to?

<b><i>That's a good question. Let's talk about that.</i></b>

## Chef and Vagrant for Test Servers

If you use Vagrant you can easily put together a test server. Unfortunately,
if you just type a bunch of commands into your Vagrant server, you're always
at the mercy of the VM going away.

Or you can use Chef. And then you can always get a clean new VM matching your
server pretty well.

With a test server, you can answer questions like, "will this work if I type
it on the production server?" And you can do it without crashing
production. So that's kind of cool.

<!--more-->

## Chef If Your Server Gets Owned

The Internet is more dangerous than it used to be. Servers get messed
up. People screw with your app, your database, your WordPress install and so
on.

If Chef can roll you a new server from scratch, you can reinstall &mdash; with
the latest security patches &mdash; in a hurry if you ever need to.

Fifteen or twenty minutes can seem like a long time, but it's a lot faster
than you can hand-roll a server.

## Chef for Staging Servers

Most people don't put together a staging server -- after all, if you just did
a bunch of one-off commands, it's a pain, right? "Most people" are missing
out on that being easy because they're not using Chef.

Why do staging when you can make a Vagrant server, like up above? Mostly to
get a really exact match for the server config. Most problems show up on a
test server on Vagrant. A few don't, because they require the exact RAM or CPU
specs on your production server, not a local lookalike.

For those last few thorny problems, a staging server is nice.

And with Chef, configuring either or both is pretty easy.

## Chef to Make Changes

Chef doesn't just put together your server in the first place. It will also
fix little things as you go along. Chef can be a great way to make sure, for
instance, that a config file stays exactly like you want it. You could re-copy
it on demand or fix it by hand, but it's kind of nice not to have to.

Better yet, you can ask Chef to do a dry-run. Then you're not making changes,
you're just asking Chef, "hey, see if anything I said to keep the same is now
wrong." It works a bit like <a href="http://www.tripwire.com" target="_blank">Tripwire</a>
that way.

## Chef as Record Keeping

It's easy to type something ill-advised. It's easy to make a typo, or to
cut-and-paste something you didn't understand. It's also easy to have your
browser insert Unicode characters or spaces are who-knows-what when you cut
and paste.

That means it's easy to configure a server slightly wrong and not figure it
out for hours.

Chef is a heavy-weight way to keep records. And it doesn't guarantee no
typos. But man, being able to go back and say "try that again, what went
wrong?" lets you find a lot more typos for yourself, doesn't it?

## Chef As About Ten Different Good Ideas

I'm a believer in getting your server reproducible and well-recorded as
quickly as possible. One way to do that is Chef (another is <a
href="http://puppetlabs.com" target="_blank">Puppet</a>, another is <a
href="http://ansible.com" target="_blank">Ansible</a>, another is <a
href="http://saltstack.com" target="_blank">SaltStack</a>, another is...)

Of course, it's easy to say "but deploying with Chef is <b>harder</b> than
doing it once!" And I have things to get done! Also, writing deploy code is
annoying when I could be writing app code! Plus I <a
href="http://xkcd.com/1319/" target="_blank">totally go off the rails
sometimes!</a>

(And you're not wrong about those.)

I have <a href="http://rails-deploy-in-an-hour.com">a solution to all of
those</a> if you want it - it costs money, but saves you a bunch of time.
It configures Chef and Vagrant and Capistrano and all the various tools,
once, and lets you mostly just drop in your Rails app requirements.

Or you can sign up at the mailing list link below and I'll email you more
about it, let you see some freebies from the class and generally keep trying
to get you to automate more. You really should, after all ;-)
