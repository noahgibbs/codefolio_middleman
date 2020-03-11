---
title: "Migration Code Review"
date: 2016-02-11 17:00
---

Migrations <a href="/posts/database-migrations-without-downtime">can
be tricky</a>, and it's time-consuming to test them properly. One
answer is to have other people look over your code.

In addition to <a href="/posts/good-strong-migrations">the checks you
can enforce with automated tools</a>, there are a lot of things a
human should look over. Let's talk about some of the rules for code
reviewing a migration that <b>aren't</b> covered by the <a
href="https://github.com/testdouble/good-migrations">Good
Migrations</a> or <a
href="https://github.com/ankane/strong_migrations">Strong
Migrations</a> tools.

## Keep Each Migration Small

Small migrations are (usually) happy migrations. It can be hard to
roll back migrations, especially when they modify large tables. If
your database supports rolling back schema changes at all, it can
still take minutes or hours to do. Even a large, hard-to-divide
operation like adding a column to a two-terabyte table is happiest
if it's mostly done by itself.

READMORE

A small migration can often be pass/fail - a single operation will
either succeed or fail. And if it's two or three operations, it's
still easier to do a manual rollback if you have to.

## Keep Most Migrations Harmless

Related to the above, try to keep each migration reversible, simple
and generally easy to handle. If you have a big complicated migration,
it's tempting to just say "you'll do this one big thing and it'll all
be fine." But if you separate it into small steps, it's easy to ask,
"how can I make this migration easy to reverse?"

## For Potentially Harmful Migrations, Keep a Backup

Sometimes an operation is destructive by nature. It drops rows, or it
drops a whole table or a database.

Where possible, keep a backup. It can be hard to have a perfectly
up-to-date backup right at the moment you drop a table, for
instance... But you can keep a <i>pretty nearly</i> up-to-date
backup. Also, if you're dropping a table, one hopes you're no longer
using it. In that case, you can back it up while knowing it's not
changing.

This can be a great place to apply the previous two rules. Worried
about dropping a table? Rename it instead, keeping the migration
harmless. Worried about changing a bunch of rows' format at once?
Separate it into adding something new, writing both, then dropping the
old one. <a href="/posts/database-migrations-without-downtime">You
often have to do that to avoid downtime anyway</a> if you have much
data.

But when in doubt, do your best, even if that's as simple as "dump the
table or database right before running the migration."

## Never Modify a Pushed Migration

Once you've pushed a migration in Git (or committed it in Subversion,
or shared it over your Dropbox Enterprise account, or pushed it as a
Rubygem, or...), you must never again modify that migration.

Specifically, Rails won't notice that the migration changed. So
developers who ran the "wrong" old version won't have their databases
mysteriously changed. Instead, they'll just have a slightly weird,
different database schema from everybody else until they drop and
recreate their local database in disgust.

Once you've pushed a migration, it's in the fossil record. Don't
change it. Instead, make a new migration to modify further.

There's an exception to this rule if you pushed a migration that just doesn't run
for everybody. Then nobody ran it, so you're safe, kind of.

But if you pushed a migration that only broke for <i>some</i>
people... Well, that's probably a bad thing that has to be carefully
sorted out by hand :-(

## Don't Add Data in a Migration

If your migration adds data rows, that's probably not good. For starter data,
it's recommended that you use seed.rb. You can have it check what rows are
there are change them to be the correct ones.

Adding rows in a migration is bad for lots of reasons, not least that
you're probably loading your model code in a migration, which is Not
Good.

## Test Rollback for your Migration

This one's easy. Run your migration forward <i>and</i> backward to make sure
it works. Then if you need to do it later, you don't have to modify the pushed
migration (ugh!) to fix it.

## Periodically Compact Your Migrations

This is controversial, but I believe in it.

An old Rails app will acquire many hundreds of migrations over its
years of service. Eventually, it will get very slow to migrate its
database. Worse, some of the migrations will be fragile, and you'll
find yourself having to debug five-year-old dodgy migration code that
you weren't even around for.

It's not good.

You can use "rake db:setup" to restore from db/schema.rb, but that
fails if you use things Rails doesn't support (e.g. triggers, procs,
materialized views...). It also doesn't work if you were naughty and
created new data rows in your migration (see above.)

Instead, pick a time in the past that everybody has migrated past. Maybe
six months ago? Take all the migrations up to that point, and replace them
with a single migration that does everything they all did.

You can mostly do that by choosing your migration date. Find the last
migration timestamp that will go in the merged version. For example,
say it was 20150701123456 (on July 1st, 2015). You'd run
"VERSION=20150701123456 rake db:migrate" to migrate to that
point. That will update db/schema.rb to be a migration which creates
the database in that state. You can mostly just copy it over to be
your new replacement migration.

For your replacement migration, name it after an existing one -- that
way, every existing database thinks it already ran that migration and
won't try to duplicate every table it mentions.

If you have any unsupported operations (triggers, data rows, views and
other database-specific stuff) you can add the code to make those
happen too. But you'll have to do it yourself rather than just dumping
the schema.

## Happy Reviewing

These aren't <b>all</b> the code review rules from
my now-defunct migration book, but they're
most of them &mdash; I want better migrations in the Rails community
more than I want to sell more books, you know?

Do you work at a Ruby shop? Put together a "code review for database
migrations" page somewhere for your project. Steal these rules for it
and/or link to this article... And also add the rules from <a
href="https://github.com/testdouble/good-migrations">Good
Migrations</a> and <a
href="https://github.com/ankane/strong_migrations">Strong
Migrations</a>. If useful, link to the <a
href="https://github.com/soundcloud/lhm">Large Hadron Migrator</a>.
