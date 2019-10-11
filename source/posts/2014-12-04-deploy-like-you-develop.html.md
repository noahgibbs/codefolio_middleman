---
title: "Deploy Like You Develop"
date: 2014-12-04 04:57
---
A few weeks ago, I was <a href="http://rails-deploy-in-an-hour.com">hacking away on prototype software for my new class</a>.
I was doing that horrible thing where you make a few changes, hit "rebuild" and wait for five minutes to find out if you
fixed the problem. And I realized something <b>surprisingly awesome</b> about configuring servers.

Deployment turned into high-end development while we weren't looking.

The best tools for configuring your server, <a href="http://getchef.com">Chef</a> and <a href="http://puppetlabs.com">Puppet</a>, now describe themselves in terms of <a href="http://en.wikipedia.org/wiki/Idempotence">idempotence</a> and <a href="http://en.wikipedia.org/wiki/Declarative_programming">declarative programming</a> &mdash;
they're using the same concepts as Big Data tools, functional languages and other theory-heavy development.

And those "best tools" aren't in a lab or a research paper somewhere. <a href="http://redmonk.com/dberkholz/2013/05/03/devops-and-cloud-a-view-from-outside-the-bay-area-bubble/">Silicon Valley already uses them and the rest of the world will soon.</a> Puppet and Chef are extremely common - my last four years of workplaces all used them. These tools just work better than the provisioning tools before them.

Like most "best tools" you don't know much about, they're a bit young and raw. "Cutting edge", you might say. "Bleeding edge" wouldn't be far off either. They're
clearly <a href="https://docs.puppetlabs.com/mcollective/">still growing new features</a> &mdash; and even <a href="https://github.com/opscode/chef-metal">whole new areas of functionality</a>.

Welcome to the new world where "deployment" is a new, interesting, involved, painful kind of development. Just like web development was fifteen years ago, and Big Data was five years ago (or now, depending who you ask.)

These days deployment and server configuration tools get <a href="https://github.com/applicationsonline/librarian-chef">bundlers</a>, <a href="https://github.com/test-kitchen/test-kitchen">deploy-specific test suites</a>, and even <a href="https://github.com/Foodcritic/foodcritic">linters</a>, not unlike how JavaScript grew <a href="http://www.jslint.com/">JSLint</a> to get you to use just <a href="http://www.amazon.com/JavaScript-Good-Parts-Douglas-Crockford/dp/0596517742">the good parts</a>.
