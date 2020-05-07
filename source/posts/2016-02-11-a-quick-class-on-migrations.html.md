---
title: "A Quick Class on Migrations"
date: 2016-02-11 18:59
tags: database
---

Interested in taking your Rails migration code to the next level?
Welcome. You're in the right place.

What's that? Somebody in the back says they're not already up on the
basics? No problem. <a
href="http://edgeguides.rubyonrails.org/active_record_migrations.html">The
Rails Guide on migrations</a> is like most Rails guides -- pretty darn
awesome. It'll have you adding tables, dropping columns and altering
multi-column indices before you know it.

For the rest of you who know the basics, let's learn what awesome
Rails programmers already know about migrations.

## Downtime

Migrations can <a
href="/posts/database-migrations-without-downtime">bring down a busy
site</a> in a hurry. Many things you do in a migration will lock the
table you're touching, which will block every SQL query and every
Rails route that touches that table, sometimes for minutes or hours.
You can't "scale" your way out of it -- you only get one database, and
it's locked for all app servers.

READMORE

There are a <a
href="https://www.braintreepayments.com/blog/safe-operations-for-high-volume-postgresql/">known
set</a> of <a
href="http://pedro.herokuapp.com/past/2011/7/13/rails_migrations_with_no_downtime/">safe
operations</a> on Postgres databases which will let you do
everything. MySQL will do <b>nearly</b> all of them, but not
quite. For those cases where you have to add an index on a huge table
or change the format of a column, there's <a
href="https://github.com/soundcloud/lhm">Large Hadron Migrator</a> --
or "scheduled maintenance", a.k.a. downtime. In both cases, <a
href="https://github.com/ankane/strong_migrations">Strong
Migrations</a> is an automated tool that can help you use only
zero-downtime migrations.

## Code Quality

Migrations are some of the most dangerous code in Rails. They're
*designed* to mess with your DB schema and often add, drop and modify
a lot of data at a time.

Luckily, you can find <a
href="/posts/migration-code-review">guidelines for code reviews</a> if
you look a bit.

There are automated tools like <a
href="https://github.com/testdouble/good-migrations">Good
Migrations</a> and <a
href="https://github.com/ankane/strong_migrations">Strong
Migrations</a> to help you follow some high-quality migration rules
and prevent downtime. But there's no replacement for code review by a
careful human being.

## Performance

Migrations add a bit of work for your database. A good no-downtime
migration (see above) isn't terrible, but it's still one more thing
going on. As a result, you'll want to schedule it to not happen during
big batch jobs or other expensive operations.

By centralizing your batch jobs (keep them all on specific hosts, or
scheduled through a central service) you can tell what's coming and
find a nice quiet time to do your migrations without disrupting other
work. Not only is that best for performance, but if something goes
wrong you know it's a problem with the one thing currently happening
-- not a finger-pointing blame game or a weird interaction between
multiple things you're doing.

If you follow the downtime-free migration recommendations above, you
can do all your migrations <a
href="/posts/deployment-and-migrations">before your code deploys even
start</a>. So not only will you have no downtime, the reduced capacity
of a deploy can wait until you've finished with the reduced capacity
from a migration. Again, try to only do one thing at once so that you
know what the problem is.

And by separating out your migrations (see the <a
href="/posts/migration-code-review">code review guidelines for
migrations</a>), keeping them harmless, testing rollback and keeping
backups, you can make it easy to handle any failures or rollbacks that
surprise you.

## Fin

Does this count as a "class"? It's pretty short... Unless you actually
follow links and learn properly about no-downtime migrations and the
code review guidelines for migrations. And then it's a pretty
significant amount of learning and will make you permanently better at
this. Very few developers do a good, thorough job on migrations. I
hope you'll join them, and save your projects and your employers a lot
of wasted time and money.

And, of course, not get fired for destroying user data.

If you read deeply and you still think, "but I already knew *all* of
this," then congratulations. You're a very solid database developer or
an incorrigible speed-reader, depending. In that case, may I recommend
a good book on databases that *isn't* Rails-specific? Or perhaps a
consultation with your local DBA? If you truly know all this material,
you're not just being a responsible database developer, but a real
database specialist. You have my respect.
