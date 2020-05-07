---
title: "Existing work on migrations without downtime"
date: 2016-02-01 18:10
tags: database
---

As I <a
href="http://codefol.io/posts/database-migrations-without-downtime">look
into database migration dangers</a> for (edited to add: now defunct)
a book I'm working on, I find
a lot of great existing stuff that I had no idea existed.

Thanks, guys!

Andrew Kane of Instacart has a bunch of wonderful guides, including
one on <a
href="https://github.com/ankane/strong_migrations">&quot;strong
migrations&quot;</a> &mdash; migrations that run without downtime on
MySQL and Postgres. It sums up some wonderful previous articles about
<a
href="http://pedro.herokuapp.com/past/2011/7/13/rails_migrations_with_no_downtime/">downtime-free
migrations on Postgres with high data volume</a>, <a
href="https://robots.thoughtbot.com/how-to-create-postgres-indexes-concurrently-in">how
to create indices without downtime on Postgres</a>, and <a
href="http://pedro.herokuapp.com/past/2011/7/13/rails_migrations_with_no_downtime/">no-downtime
migrations in general.</a>

READMORE

It turns out there was a whole world of information that was left
behind by all the <i>previous</i> schmucks who froze gigantic tables
with huge migrations. Heck, for some MySQL operations they wrote <a
href="https://github.com/soundcloud/lhm">complex tools with ominous
names</a> to handle the fact that you can't safely add an index to a
large table, period.

And I'm ignoring lots of other great information on databases
generally and migrations specifically. I mean, the <a
href="http://edgeguides.rubyonrails.org/active_record_migrations.html">Rails
Migration Guide</a> is an amazing intro, and even that didn't exist
when I started learning Rails, (*cough*) years ago.

If, like me, you started as a complete ignoramus about databases, there has
never been a better time to learn this stuff!

(Why is it hard to migrate your database without downtime? Turns out
that SQL databases lock everything down while they make the change
&mdash; so if you change the type of a column in a table so big it
takes five minutes to modify the rows... You may wind up with five
minutes where all the queries on that DB fail. There's more to it than
that. <a
href="http://codefol.io/posts/database-migrations-without-downtime">I
wrote an article, if you're curious.</a> Or you could read some of the
other ones.)
