---
title: "Do We Need Both Capistrano and Chef?"
date: 2014-08-26 15:49
tags: deployment
---
Deployment comes with far too many tools. For instance,
this whole set is often used together:

* <a href="http://vagrantup.com">Vagrant</a>
* <a href="http://www.virtualbox.org">VirtualBox</a>
* <a href="http://getchef.com">Chef</a>
* <a href="https://github.com/applicationsonline/librarian-chef">Librarian-Chef</a>
* <a href="http://capistranorb.com">Capistrano</a>

<img src="/images/cap_and_chef/librarian-chef.png#right" width="184" height="203" title="This guy really is a librarian chef."></img>

And that's not counting the smaller things like Vagrant plugins, Capistrano plugins, the many Chef cookbooks and so on, which would <b>also</b> be used with these. And it's
definitely not counting the many, many competitors. That whole list is just <b>one</b> stack of tools.

For some of them, it's clear why you use them. VirtualBox? Yeah, okay, something has to make a VM if you test locally.

But why do you need both an "app deploy" tool (Capistrano) <b>and</b> a "server configuration" tool (Chef)? Can't your server configuration just include your app? For that matter, if your "app deploy" tool runs scripts as root, can't it configure your server?

## There Can Be Only One?

Some people do use just one. It's possible to deploy apps through Chef,
but please don't! It's possible to do all your server configuration through
Capistrano &mdash; really, really don't.

For best results, think of Chef and Capistrano as two separate tools for two different jobs.

So what are those jobs?

READMORE

## Bring Out the Five-Dollar Words

Capistrano handles deployment as <b>events</b>. When you deploy, it makes a nice new deploy version of all the files, separate from the previous deploy. Then it switches a single symbolic link to put the new files in place. Want to <a href="http://stackoverflow.com/questions/496998/how-do-you-roll-back-to-the-previously-deployed-version-with-capistrano">roll back</a> a version that didn't work? No problem. Capistrano easily, quickly changes the symbolic link and you're good to go.

Capistrano also handles separate smaller events that depend on the first one: when you deploy, you'll often run migrations, rebuild asset files (like minified JavaScript), clear caches, install gems and do other app-specific setup.

But it usually boils down to "run this code" - usually Ruby code or Bash code. It's treated as a set of actions to take.

<img src="/images/cap_and_chef/dont-always-write-tests-239x300.jpg#right" width="239" height="300" />

Chef <a href="https://www.chef.io/why-chef/">is all about idempotence</a>. That means you tell is "make all this stuff true" and it does. That's a pretty cool way to set up a server, but it's pretty bad for app deployment. "Use the latest version" isn't a constant state (not idempotent) and it's not exactly what you want anyway.

What does "make something true" involve? For Chef it usually boils down to "put a file in this location" or "install this package" or "use this app configuration." More rarely it might mean "keep this process running" (often via <a href="http://smarden.org/runit/">runit</a>) or "there must be no file at this location." <a href="http://docs.getchef.com/chef/resources.html">There are a lot of things Chef can keep true for you.</a>

<img src="/images/cap_and_chef/make-it-so-captain.jpg#left" width="308" height="217" />

Where Chef's approach falls down is when you care less about the result and more about the process, like with zero-downtime deploys. Sure, it's great that you wind up with all the right files and processes in place, but can we avoid taking down the application while we do it? This is Capistrano's strength and Chef's weakness.

Where Capistrano's approach falls down is when you care a lot about permissions or content. Capistrano, at heart, works by SSHing into a machine and running commands. That's a terrible way to put files in place, and it's a slow way to verify the machine's existing state. Chef is much better than Capistrano to make tiny, incremental changes to a machine that's nearly correct.

By the way, many competing tools don't make this division in the same way. For instance, <a href="http://www.ansible.com">Ansible</a> or <a href="http://www.saltstack.com">SaltStack</a> tend to treat everything more like orchestration, which is a hybrid between Capistrano and Chef. That comes with its own tradeoffs.

## So What's the Reason To Use Both Again?

Chef is good for situations where you say "here are a bunch of things I want for my host to be. Make sure they stays true."

Capistrano is good for situations where you say "here's an update or an operation. Make it happen."

They sound pretty similar, but they're actually quite different.

Make sense?
