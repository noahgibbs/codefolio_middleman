---
title: "Starting Rails programming"
date: 2012-05-11 23:08
disqus_id: "http://codefol.io/posts/6"
---
I tutored Rails at CMU West for a bit.  They asked me for recommendations for what the students should be doing to prepare for Rails programming.

You know, that's advice I can share with *anybody*.  Here's what I wrote:

<hr/>

Sure, I can help a bit with this.

Michael Hartl has an excellent free tutorial which is already given as a resource to the students.  I'd definitely recommend sending them the link earlier so that can start looking at it sooner.  It really is the best thing out there.  Paper books exist but go out of date frequently, cost money and are otherwise less convenient.  The Rails interface changes frequently and paper books haven't done a good job of keeping up with it.

I'd suggest a programming assignment rather than a reading assignment to get started -- don't tell them how much of Michael Hartl's tutorial to read, tell them what to accomplish and they can read what they need to get it done.  That's better real-world practice anyway.  Similarly, Google is a *fantastically* useful tool for Ruby and Rails programming and every sub-topic, so tell them they can and should use Google frequently, especially for error messages.  It's miraculous how well it works for about 80% of programming and configuration errors.  Again, an excellent habit for later real-world programming.

I'm pretty sure you also give them a link to the online "Pickaxe Book", Programming Ruby ("http://www.ruby-doc.org/docs/ProgrammingRuby/"), which should be thoroughly adequate to their early Ruby needs.  There *are* at least some better paper books on Ruby than on Rails.  It changes less frequently.  The later edition of that same book, "Programming Ruby 1.9" is also good, and Ruby 1.9 has some changes from 1.8.  But overall, the older free book online is fine.

I don't have a strong opinion about "Ruby then Rails" versus "Rails then more depth with Ruby".  You can do Rails programming with very little Ruby sophistication in many cases, but eventually they'll need both.  I haven't seen a compelling argument that one has to come before the other, in either direction.  So make sure the students have access to online references for both and you're probably fine.

This probably all sounds very handwave-y.  It should.  Fundamentally, the most valuable skill you can teach them here is how to learn by constant online browsing supported only occasionally by partly-outdated "authoritative" materials.  Programming languages are starting to move fast enough that traditional publishing can't support them properly, now that online publishing can at least attempt it.  Online API references, language references, and eventually source code are the things that stay up-to-date, along with understanding of how to browse blogs, StackOverflow and so on for what they need.  Google, in turn, will lead to those blogs, StackOverflow and so on.

Some fun possibilities for small, easy-with-Rails-type programming tasks:

  * Put together a blog.  Example recommended feature list:  format post with markdown-or-something, add keywords to each post, search by keyword.  Extra credit: search titles by keyword.

  * Write a snippet-or-something rating program (examples: submit code and rate it, submit quotes and rate them).  Example feature list: users can submit core-or-quotes-or-whatever, users can vote, program counts votes, show top 10 list of most popular quotes.  Extra credit: allow a user to change their vote later, make sure votes only count one-per-user.  Extra-extra credit: statistical confidence so that you can decide how a new quote with four up-votes and one down-vote should compare to an old one with 35 up-votes and 20 down-votes (an interesting question, with many fun possible answers!).

Feel free to cut those projects down if they sound too ambitious.  They *are* specifically chosen to map well to what Rails offers, but especially with extra credit they're not necessarily easy.  They are also chosen to be fairly free-form, which I think is good preparation but may be a little much for beginners...

Feel free to call me at XXX-YYY-ZZZZ if you'd like to discuss further.  I just thought I'd put something in writing to start out.
