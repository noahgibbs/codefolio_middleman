---
title: "What's Deployment versus Provisioning versus Orchestration?"
date: 2015-04-13 16:38
---
<img width="315" height="409" src="/images/orchestration/bad_google_search.png#right" alt="dubious search results" title="At least _you_ knew to search on deployment..."> </img>
Hey, Ruby web developers! Having trouble asking deployment questions?
Not sure what Provisioning or Orchestration are? Getting bad results
Googling your questions, but not sure why?

Let's go over some deployment vocabulary from your point of view
&mdash; that makes it a lot easier to Google and to read information
about deploying your app to a server, and setting up that server in
the first place.

As a nice side effect, you may have an easier time talking to your Ops guy at work.

First, let's go over what the word "deployment" means:

## Deployment

<b>&lsquo;Deployment&rsquo;</b> is the process of putting a new application, or new
version of an application, onto a prepared application server.

If you are talking to a developer, it may also mean the process of
preparing the server, perhaps by installing libraries or daemons.
<b>If you are talking to an operations professional, it DOES NOT.</b>
They use the word "provisioning" for that.

(Developers are going to keep using the word "deploy" for everything
involved in getting our app and its dependencies installed. That's
cool. But don't be surprised if you confuse your Ops guy.)

READMORE

Ruby developers often use <a href="http://capistranorb.com/" target="_blank">Capistrano</a> or <a href="http://nadarei.co/mina/" target="_blank">Mina</a> for deployment.

## Provisioning

The word &lsquo;<a target="_blank"
href="http://en.wikipedia.org/wiki/Provisioning">Provisioning</a>&rsquo;
is normally used by Ops folks to refer to getting computers or virtual
hosts to use, and installing needed libraries or services on
them. They use the word for a lot of other things as well, such as
buying access to network bandwidth, but you can probably ignore that.

The thing to remember is that &lsquo;deployment&rsquo; does not, as a
rule, include &lsquo;provisioning&rsquo;.

Ruby developers often use <a target="_blank" href="https://www.chef.io/get-chef/">Chef</a>, <a target="_blank"
href="http://ansible.com">Ansible</a> or <a target="_blank"
href="http://puppetlabs.com">Puppet</a> for server provisioning. This
can also be done automatically by a service like <a target="_blank"
href="http://engineyard.com">Engine Yard</a>, <a target="_blank"
href="http://heroku.com">Heroku</a> or (briefly)NineFold
(but NineFold seems to be gone).

## Orchestration

<img width="256" height="143" src="/images/orchestration/orchestra_512_287.jpg#right" alt="orchestra" title="The blond kid is totally an app server."> </img>

Now we're getting a little less common.

<a target="_blank"
href="http://en.wikipedia.org/wiki/Orchestration_(computing)">Orchestration</a>
means arranging or coordinating multiple systems. It's also used to
mean "running the same tasks on a bunch of servers at once, but not
necessarily all of them."

Normal uses are things like:

* Run the latest migration on all your database servers, but not all your Rails app servers
* On each Rails server, check the current Ruby patchlevel and send it back
* Check "ps" and make sure that Daemontools is still running on every server, everywhere
* Find any Node.js processes and terminate with extreme prejudice ;-)

The most common orchestration tool for Ruby programmers is Capistrano, followed by Mina.

Orchestration tools include <a target="_blank"
href="http://www.fabfile.org/">Fabric</a>, <a target="_blank"
href="https://puppetlabs.com/mcollective">MCollective</a>, <a target="blank"
href="http://saltstack.com/">Salt</a> and many more. It's pretty
common for your Orchestration tool to also be a provisioning tool
(Salt, arguably Ansible) or an app deploy tool (Capistrano, Mina), or
potentially something else as well.

Of course, that's only if you don't count SSH, the most common
orchestration tool of all :-)

Here's a bonus: Configuration Management.

## Configuration Management

Config Management is part of provisioning. Basically, that's using a
tool like Chef, Puppet or Ansible to configure your
server. "Provisioning" often implies it's the first time you do
it. Config management usually happens repeatedly.

Config management tools normally take "facts" to make true about the
server -- "make sure /etc/my.cnf contains this" or "NGinX should be
running with the following config files." The facts are accumulated
into modules ("cookbooks" in Chef). But that's what a module is made
of.
