---
title: "Good Strong Migrations"
date: 2016-02-08 18:00
mc_signup: database
---

Remember that <a
href="/posts/database-migrations-without-downtime">problem I had
writing migration code where the whole site went down?</a> Turns out I
could have fixed that in advance by just following best practices for
migrations.

There are several libraries meant to help you follow migration best
practices. Two of them are <a
href="https://github.com/testdouble/good-migrations">"Good
Migrations"</a> and <a
href="https://github.com/ankane/strong_migrations">"Strong
Migrations"</a>.

Good Migrations is basically "don't use models in your migrations."
It's true, don't. Most people already don't, but Good Migrations
enforces it.

Strong Migrations is "only use migrations that can run with no
downtime and not screw anything up." This may cramp your style a
little more since you can't do things like change the type of a
column. There's no safe way to do it, so Strong Migrations stops you.

You can learn a little more about <i>why</i> to be careful with these
things from <a href="http://no-more-lost-data.com">No More Lost
Data</a>, my book on migrations.

You can also learn more about <a
href="http://codefol.io/posts/database-migrations-without-downtime">the
whys of migrations with no downtime</a> here and in the book.
