---
title: "Many Unix Commands Are Actually Jokes..."
date: 2019-10-21 11:00
---

There are a lot of weird Unix command names. Where do they come from?
One answer is: a lot of them are jokes. I don't mean I disapprove - I
mean they're literally meant to be funny.

For instance: there's a command called "cat", short for "concatenate." When you use it on a file (or several), it prints them out. Okay...

But if you want to print a file *backwards*, you use "tac" - the "cat" command, but backwards.

A long time ago, you'd use something like "cat" to see a file. But of course, if you have a big file it will print out the whole thing, spewing vast amounts of text, sometimes for a long time. You needed a 'pager' program to stop that - something that would stop about once per page and let you hit "enter" or the spacebar before you went to the next page. Early pagers sucked - they didn't print anything, so you just had to know to hit "enter". Early computers were slow, so it often seemed as if your terminal (or whole machine) would just hang.

So somebody had a brilliant idea - print "more" at the bottom before waiting for "enter". Now you could see it was doing something. So they named the command "more." Okay.

Why do you now pipe the output to "less"? Because ["less" is "more"](https://en.wikipedia.org/wiki/Less_is_more).
