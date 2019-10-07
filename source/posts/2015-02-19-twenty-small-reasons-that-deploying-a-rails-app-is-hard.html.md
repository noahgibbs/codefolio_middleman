---
title: "20 Small Reasons That Deploying a Rails App Is Hard"
date: 2015-02-19 21:43
---

Are you deploying a Rails app? Here are lots of things you'll probably have to
watch for as you do... I've been writing <a
href="http://github.com/noahgibbs/madscience_deploy_repo">an open-source
gem</a> and a <a href="http://rails-deploy-in-an-hour.com">for-pay online
class</a> about this for months now. Let me share some things.

There are lots of big reasons that deploying a Rails app is hard. And lots of
well-known, big tasks. But when you're provisioning a server and deploying
your application to it, <b>lots of little things go wrong too</b>.

I feel like the big things get a lot of respect already. Let's look into some
of the under-appreciated little things you have to get right in order to make
a good deploy happen.

For starters, a lot of these small issues can require a lot of debugging. You
know those two-line fixes that take three hours to find? Deployment is full of
those. Here are some of mine to speed you on your way.

## All Things Great and Small

* You can't compile recent Ruby on a VM with less than approximately 1GB of RAM. The amount varies a bit, of course.

* When you try, you discover that <a href="http://stackoverflow.com/questions/13103396/c11-g-4-7-internal-compiler-error">GCC gives an internal compiler error as its "out of RAM" notice</a>. Also, that the <a href="https://github.com/fnichol/chef-rvm">RVM cookbook</a> tells you a completely wrong directory for the six logfiles to check for errors. At least, if you install RVM in user directories.

READMORE

* All the tools are pretty opaque about what's going wrong, naturally. It's not that they don't try. It's that it's really, really hard for the tool to get it right. Do they swamp you in 99%-the-same command output, or suppress a bunch of messages you really wish you could see? And this is running on a server, so you usually need to log in to go check the logfile.

* If you install RVM in a user directory, it's easy to install gems to it during app push, and you don't have to deploy apps as root. Yay! But then if you have a server with multiple user roles, they each have to install Ruby, which takes 5+ minutes per Ruby.

* If RVM and the <a href="https://github.com/fnichol/chef-rvm">RVM Chef cookbook</a> get out of sync, RVM will try to install various required and semi-required packages using sudo. Your "look, I'm busy automating right now" Chef process will just freeze if this happens and you haven't added the right non-default magic "don't do that" option for the cookbook.

* If you fail when building a version of Ruby, <a href="https://github.com/fnichol/chef-rvm/issues/182">the Chef cookbook won't notice</a>. For instance, if you didn't have enough RAM (see above.) It'll just keep going with a warning!

* Using "vagrant push" with Capistrano appears to be a dark art, requiring <a href="https://github.com/mfenner/vagrant-capistrano-push/blob/master/lib/vagrant-capistrano-push/push.rb">a bizarre combination of unsetting environment variables and using a subshell</a>.

* If you run Ruby stuff from Vagrant, you have fights between the Vagrant settings (environment variables, Gemfile) and the ones you'd like to use. For instance, Capistrano errors out by telling you that Capistrano isn't in the Gemfile (and it *isn't* in Vagrant's Gemfile.) That's why you need the bizarre bits above to run Capistrano, for instance.

* If you repeatedly use a hosting service like Digital Ocean, Linode or AWS, it will occasionally reassign you the same IP address. That plus creating a new server will convince SSH that the server changed keys, looking like a man-in-the-middle attack. SSH will, naturally, freak out about this.

* Until very recent versions, Git required you to create a wrapper script if you wanted to set a specific SSH key to clone with. This is <a href="http://stackoverflow.com/questions/20470076/git-authentication-in-chef">reflected in Chef's Git resource</a>, alas.

* Also, this git cloning depends on how the user has SSH keys set up. Which has subtly weird interactions with sudo, because "sudo" is short for "so don't expect me to guess who you are, buddy."

* If you want to know about where you're pushing using Vagrant (e.g. Digital Ocean - but what IP address and user?) you pretty much have to parse the output of 'vagrant ssh-info' in SSH config form. This is subtly different from SSH's own command-line options, and very different from all the SSH libraries you actually use.

* If you turn on <a href="https://developer.github.com/guides/using-ssh-agent-forwarding/">SSH agent forwarding</a>, sometimes that will allow you to use subtly wrong SSH keys for checkout, because you're also getting the right ones via agent forwarding. You know, until you run from a different machine and/or to a host that doesn't get agent forwarding right, and then it all fails.

* If you <b>don't</b> turn on SSH agent forwarding, you force the user to put private SSH keys somewhere you can read them.

* If you deploy to real production, you need a bunch of hosting-specific settings. For instance, you need to know what region and (possibly) availability zone for AWS, what instance size for any provider, what image in a provider-specific format... And many providers, like Digital Ocean, don't give a list of those. <a href="https://github.com/smdahlen/vagrant-digitalocean/issues/93">You have to dynamically query the API</a>.

* You need a Vagrant box for development that matches (well enough?) your provider-specific deployment box. Packer will fix this with enough work and if you want everything to be even slower again... But you have to pray that everybody involved packaged "only the basic distribution" with no modifications, whatever that means for your distribution.

## Bonus Security Problems

* You want database.yml created during deploy, not with passwords hardcoded in your app's git repo. And those passwords should match the server you're just now deploying.

* Until very recently, <a href="https://github.com/mitchellh/vagrant/issues/5059">Vagrant used known passwords (including for root!) and specific, insecure known SSH keys for "security"</a>. This isn't great for deploy to a VM, and it's utterly horrible for deploying to a real host on the Internet.

* You would really, really like not to put your all-the-privileges keys-to-the-kingdom private SSH key on the deployed machine. At all. Ever. But if you want to clone a Git repo from it (like how Capistrano and Chef app-deploy cookbooks do this), you need a private key there. So you can either have multiple sets of keys, or put a very dangerous key onto a VM you worry may become insecure.

## In Conclusion

There are a multitude of fiddly bits to get right when doing your
deployment. I hope I've saved you some time and effort!

And next time you're deploying a Rails app, I hope you'll have a look at <a
href="http://github.com/noahgibbs/madscience_deploy_repo">Ruby Mad Science</a>
and/or <a href="http://rails-deploy-in-an-hour.com">Rails Deploy In An
Hour</a> -- I've put a lot of very annoying work into them, as you can read
here ;-)
