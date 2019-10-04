---
title: "Timing Attacks Are Really Tricky"
date: 2012-08-01 00:40
disqus_id: "http://codefol.io/posts/19"
---
<a href="http://kalzumeus.com">Patrick McKenzie</a> mentioned in a <a href="http://news.ycombinator.com/item?id=4280503">Hacker News comment</a> that it's easy to leak database information with a timing attack, and that it's silly to secure that information very much in other ways if you aren't going to block the timing hole.

He says "Some folks think there are trivial ways to defeat timing attacks. You are either mistaken or you have a very different view of the word "trivial" than I do."

He is correct.

Much debate followed, often of the "just pad the total time up at the end and then they can't tell!" That is, many people think this is a trivial thing to defeat.

<a href="http://news.ycombinator.com/item?id=4282991">They are wrong</a>.

Here's the problem: your web site is a system with large, complex pieces. Those pieces operate in a mostly-predictable way. Query an account? That hits the database with the same query every time. Reset a password? Also a known set of database queries. Queue a task to reset the password? There's a delay, but it's always the same set of database queries.

This isn't predictable in that if an attacker does it once, there's lots of sources of noise. The queueing system will be doing other things. The web site will have other load. They get a single measurement, and that measurement is probably garbage.

But they don't just get one measurement on that same machine right at the time.

They can pick <i>any visible part of your system</i> and see how it responds.

Other URLs? Sure. Different sites that share a queueing system? Yup. Do other things that enqueue a task and check the delay? Yup, they can do that. SSH in and see how long it takes to give a prompt? Often, yes.

You're not just fixing a single point where the attacker can check the behavior of your system. The attacker can pick *any* part of your system.

If you pad out the time it takes for the query with busy-waiting, other URLs will be slowed down. If you pad it out with sleeping, they won't. Both are different depending on how long the query actually took. If resetting a password requires more queries, or queries to different tables, than if the password doesn't exist then some URLs (that use those tables) will be slowed down.

Again, quoting Patrick:

<i>The attacker wins with microsecond precision over the open Internet and nanosecond precision over the local network, which is plausibly achievable on all of the cloud providers than HNers like to host their apps at. Microsecond precision is enough to discriminate between "record in DB" and "record not in DB" on many plausible application architectures, even if your HTML/headers returned are exactly identical for the two cases (and they frequently won't be out of the box).</i>

His measurements there assume the attacker can check repeatedly. But an attacker who knows statistics can check again and again and can, eventually, determine the difference at microsecond precision over the 'net.

Can't you just block that attacker? Not if they use a botnet or enough forged IPs. Can't you rate-limit them? Only if you can let them lock out all your real users.

The problem is that computers are hugely, delicately interconnected. What *would* solve these problems are highly-enforced resource quotas with no sharing between all your tasks.

Of course, then everything is unshareable and your costs go way up.

Defeating timing attacks is really, really hard.

By the way: what *would* work is if you could pad out the total work with <i>exactly the same load</i> between hits and misses on all of your infrastructure. Always queue a job, always return a user (but a false one), always make the database objects, all the way through the whole process. Do not allow a full nanosecond of difference between the two.

And that's the part that's really, really hard.

Do you like deep technical minutiae and understanding your whole application stack deeply? I'm writing <a href="http://rebuilding-rails.com">a book that can help with that</a>...
