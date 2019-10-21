---
title: "Deployment and Migrations"
date: 2016-02-11 18:45
mc_signup: database
---

A question you'll occasionally see: when do you run your migrations in
production? There's a standard answer, so let's talk about it.

## The Answer

You'll run your migrations before you deploy new code. In general,
that means "every time you push code to production, you run all the
migrations since the last time you pushed code to production. Do it
before you replace the old code."

Easy enough. Why?

First, because that's the order you think about things. If you're
adding a new column to a table, you'll want to make your code use
it. If you run the migration first, that all works out nicely.

READMORE

It doesn't work for <i>dropped</i> columns, but that's why <a
href="/posts/database-migrations-without-downtime">dropping a column
can be a little tricky</a>.

Running the migration afterwards is <i>possible</i>, but usually
annoying. If it takes two (or more) migrations to drop a column, well,
you weren't using that column anyway. If it takes two migrations to
<i>add</i> a column, you're very sad that you'll have to wait a deploy
(a day? a week? a month?) before you can add that new feature.

Second, it makes it clear *when* to do it. If you're deploying to a
cluster of four or five app servers, you don't want to have to turn
them all on a dime from the old code to the new code. Realistically,
there's going to be a bit of "gray area" between the old and new code
when not everything has switched over. So you should assume you're
going to have both the old and new code running at once. So the only
safe times to run the deploy are before <b>all</b> of that, or after
all of it.

And "after", again, has some problems.

## Why Not Both?

Technically you could have some kind of "pre-deploy migrations" and
"post-deploy migrations" be separate. But the more steps you add, the
more complex you're likely to find your deployment... and
rollback. What do you do if the pre-deploy migration succeeds and the
post-deploy migration fails? Do you have separate rollbacks for each?
Or do a rollback even though things "basically worked?" It's possible,
but... well, better you than me. In general, try to simplify. Having
multiple separately-reversible stages of migrations isn't likely to be
the simplest solution.

## So...?

Most tools will just choose this for you. If you're running <a
href="http://capistranorb.com">Capistrano</a>, say, it will quietly do
the right thing without fussing over it. So if you expect the right
thing, everything will "just work."

Now you can expect the right thing, because you know what it is. And
in one more situation, everything will quietly just work because you
knew how to write your migrations.
