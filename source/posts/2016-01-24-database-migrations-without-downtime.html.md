---
title: "Database Migrations Without Downtime"
date: 2016-01-24 16:05
tags: database
---

Back when I worked at <a href="http://on-site.com">On-Site</a>, years
ago, I screwed something up in my code. I discovered it when
everything stopped working in production.

Oops.

By "everything" I mean "nearly every action a user could take would
just hang." So that's not great.

But I learned something important about database migrations. And that's
nearly as good as <b>not</b> crashing production, right?

Right?

I'll tell you what happened with me and crashing our servers, but first let's
talk about database migrations.

READMORE

It turns out that testing a migration on your own machine won't show
you any bugs that happen with bad data, or too much data. You probably
migrate often, so it won't show you any bugs that only happen when you
run *several* migrations back-to-back.

Luckily, you have a staging server to catch these problems. You do, right?
But it also gets migrated often. And it probably *still* has much less data
than production. So you'll see fewer "bad data" bugs and *lots* fewer "way too much
data" bugs.

D'oh! You meant the staging server to *catch* more bugs.

If you do something slow like adding a column or an index, the
database will take a break from doing anything else with that table.
It locks it down hard. That means minutes or hours of downtime before
anything touching that table can run. In the mean time, your
site is down for as long as the operation takes.

Oops?

So by now you've figured it out. I added an index on a table. On my
dev laptop, it was instant. On staging it was instant. In production,
it took about ten minutes, but nobody was sure how long it was going
to be. Ten minutes later the site was back up. I was lucky &mdash;
On-Site sold to realtors, so ten minutes was a reasonable maintenance
window, and everything turned out okay. Of course, I sweated bullets
the whole ten minutes...

And now you know &mdash; slow database operations can take your whole
site down randomly.

I'm going to write a lot more on this topic. It turns out that there
are specific database operations that cause downtime and specific safe
changes. Sign up below for more of that (or hit the "next" button, if
it's there yet.)
