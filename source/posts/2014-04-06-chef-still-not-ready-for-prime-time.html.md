---
title: "Chef: Still Not Ready for Prime Time"
date: 2014-04-06 12:01
---

I love the idea of <a href="http://www.getchef.com">Chef</a> and <a
href="http://puppetlabs.com">Puppet</a>. And to me, that idea is
"let's just declare everything we want to be true about a server and
it can magically spring into existence." Better yet, of course, is
trying it out locally and then pushing it out, as Chef plus <a
href="http://vagrantup.com">Vagrant</a> promises.

Especially that server is declared as "NGinX should be installed"
rather than "download this file, copy it here, unzip and build it..."
Chef and Puppet, each in their way, is a possible vision of that
future.

Of course, right now they are <b>not</b> ready for casual use.

## But Aren't They Both A Few Years Old?

I started with Chef several years ago. It was a bit of a mess --
significant changes like <a
href="http://docs.opscode.com/lwrp.html">Lightweight Resources and
Providers</a> that were supposed to change everything and the rewrites
that followed. <a href="http://berkshelf.com/">Berkshelf</a>, and
then later its acquisition and significant rewrites.

Basically, a fair bit of churn and chaos. Just what you'd expect of a
new idea that's turning into something you can use.

Puppet, of course, was doing almost exactly the same thing with the
Puppet 2 to Puppet 3 transition, modules and whatnot.

And now they're both still churning with things like <a
href="https://github.com/applicationsonline/librarian">Librarian</a>,
a <a href="http://gembundler.org">Bundler</a> for Chef and Puppet.
And Berkshelf, <a
href="https://github.com/test-kitchen/test-kitchen">Test Kitchen</a>
and other fun tool changes.

To be clear: each and every one of these is basically a good idea.
Some day, when Chef integrates them nicely, I think it will be an
amazing solution.

## Is This Just Theory?

Right now, the problem manifests in ways like the fact that you can't use
the latest version of the build-essential cookbook (one of the very
basic ones) with the version of Chef that comes with Vagrant -- you
have to figure out you need a different Chef version, and use <a
href="http://stackoverflow.com/questions/11325479/how-to-control-the-version-of-chef-that-vagrant-uses-to-provision-vms">one
of several hacks or plugins</a> to make it work. This isn't really
documented... You just have to figure it out.

Plus, many Chef cookbooks don't yet support the new LWRPs, and many
Puppet cookbooks don't support the Puppet-3-style modules, and all
kinds of things are broken because they're "old" -- often only six to
twelve months out of date, but that's already old.

There are still a <i>lot</i> of rough edges.

Chef and Puppet will both be amazing, given time. However, as a
non-Devops person... You can expect that they'll both be changing a
lot for awhile, and that they'll be unfriendly to casual users for
awhile yet. Upgrades will remain painful, probably for at least
another year or two.

And likely more.

I look forward to the future, when <a
href="https://leopard.in.ua/2013/01/04/chef-solo-getting-started-part-1">a
well-written year-old tutorial</a> doesn't require three or four
updates to work with recent versions of everything. And we'll get
there.

We're just not there yet.
