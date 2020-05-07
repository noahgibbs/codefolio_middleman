---
title: "Selecting the Right Chef Cookbook: Attributes, Recipes, Data Bags"
date: 2015-04-22 15:11
tags: deployment
---
<img src="/images/right_cookbook/old_cookbook.png#right" width="210" height="300" alt="an old Australian cookbook"></img>
There are many <a href="http://jtimberman.housepub.org/blog/2011/09/03/guide-to-writing-chef-cookbooks/">guides
to writing a Chef cookbook</a>.

But can you choose the right <a href="https://supermarket.chef.io/">existing cookbook</a>?

Let's talk about how to choose, especially for <a href="https://docs.chef.io/chef_solo.html">Chef Solo</a>,
<a href="https://github.com/chef/chef-zero">Chef Zero</a> or <a href="https://github.com/noahgibbs/madscience">MadScience</a>.

READMORE

Already know the basics? Skip ahead to <a href="#howToChoose">how to choose</a>.

## Basic Terms: Attributes, Recipes, Data Bags, Resources and Providers

A cookbook is meant to install a piece of software. But you can usually configure that software in a lot of ways.
You can use <b>recipes</b>, <b>attributes</b> and <b>data bags</b> to install in a fairly simple way, or you can
write your own cookbook to call cookbooks based on <a href="https://docs.chef.io/lwrp.html">LWRPs</a>.

We're going to focus strongly on recipes, attributes and data bags. If you preferred to write your own cookbook,
you'd be reading a different online guide, right? Part of the point is to use somebody else's.

<a href="https://docs.chef.io/attributes.html">Attributes</a> are things like the version of the software, paths or URLs you need for install, and other configuration
data. You normally set them with a JSON file on each Chef run, and you don't normally expect their values to stick around.

Data Bags are similar, but you can write back to them. You can also use them to <a href="https://docs.chef.io/chef/essentials_data_bags.html">safely store encrypted
data</a>, though running serverless (like <a href="https://github.com/noahgibbs/madscience">MadScience</a>) allows you to achieve that result in a different way using SSH.

And again, we're mostly going to ignore resources and providers. You can't invoke them by setting attributes or data bags,
so you'd need to write a cookbook. That's not what this guide is about.

<a name="howToChoose"></a>
## Popularity

First, you'll want a feel for how popular and regularly-used the cookbook is. There are two places you should always check.

### GitHub

Most cookbooks store their source code on GitHub. You can find it with a Google search. Make sure to pick the right one - it's quite possible to
have multiple cookbooks with the same name.

You can judge GitHub popularity in the usual ways: read the README. See how many stars or forks the cookbook has. See what issues have
been opened and closed. Check pull requests, and how responsive the maintainers are.

The primary thing to do is make sure there's at least some level of activity. If there's a bug, do you want to have to fix it yourself?
You may have to in some cases, but it's great when you don't.

<img src="/images/right_cookbook/github-cookbook-banner.png" width="512" height="120" alt="The top banner of GitHub"></img>

### Supermarket.chef.io

You can search <a href="http://supermarket.chef.io">Supermarket.Chef.io</a> directly &mdash; or Google will normally find the cookbook on it anyway.

Supermarket has the same kind of activity statistics as GitHub, but with more Chef specifics. Is it a cookbook from the Chef company? That's always a good sign.
Or from reputable developers? Does it have a lot of downloads? A lot of followers or released versions?

Again, you're mostly looking for a cookbook with some reasonable activity. And if you're choosing between multiple and there's no specific feature you
need, you should normally choose the more active of the two.

If there **is** a specific feature you need, keep reading.

Here's what those areas actually look like <a href="https://supermarket.chef.io/cookbooks/mysql">on a popular sample cookbook</a>:

<img src="/images/right_cookbook/supermarket-top-bar.png" width="425" height="65" alt="The top area of Supermarket.chef.io"></img>
<img src="/images/right_cookbook/supermarket-sidebar.png" width="357" height="621" alt="The side area of Supermarket.chef.io"></img>


## Functionality

It's great to choose by how popular a cookbook is, and by how well it's maintained. But what if it doesn't do what you want?
How can you tell?

A great cookbook is well-documented. A good cookbook at least mentions the attributes and recipes, probably in the README.
An okay cookbook is going to make you read through it, alas.

The README is available on the plugin's top page on GitHub or Supermarket. So that's normally the first thing you read.

### Choosing Your Cookbook: Attributes

It's useful to check the set of attributes.

In case you need to read the code: a cookbook generally has an "attributes" directory, and generally an attributes/default.rb file
with a lot of lines like this:

```ruby
default['mysql']['service_name'] = 'default'

# passwords
default['mysql']['server_root_password'] = 'ilikerandompasswords'
default['mysql']['server_debian_password'] = nil
default['mysql']['server_repl_password'] = nil

# used in grants.sql
default['mysql']['allow_remote_root'] = false
default['mysql']['remove_anonymous_users'] = true
default['mysql']['root_network_acl'] = nil
```

Each of those lines is setting up an attribute that the cookbook will potentially use later.

You can also look in the templates/default directory
in the cookbook &mdash; that's where configuration files are often kept, and those often substitute in
values of attributes. There's a files/default directory, but those files are normally used as-is rather than
substituting.

You may also have some luck Googling for the cookbook by name. It's especially useful to look for
StackOverflow questions, which mean people having trouble. Or blog posts, which can be good or bad
but usually have a lot more information.

The best, of course, are well-used cookbooks that people like.

<img style="border: 2px solid black;" src="/images/right_cookbook/postgres-attr-docs.png#right" width="487" height="301" alt="Attribute docs from the Postgres cookbook"></img>

## Choosing Your Cookbook: Recipes

As with attributes, it's best if the README documents these directly. You can read the code, but it's not a
great sign if you have to.

The basic recipe with the same name as the cookbook is normally in recipes/default.rb. If you have a recipe
called WhateverCookbook::Foo, it's normally in recipes/foo.rb &mdash; in WhateverCookbook's directory, of course,
probably under "cookbooks".

You can use a recipe from your runlist (see below), or you can use it from another cookbook via
<a href="http://stackoverflow.com/questions/16947393/should-i-use-include-recipe-or-add-the-recipe-to-run-list">include_recipe</a>.

<img style="border: 2px solid black;" src="/images/right_cookbook/postgres-recipes-docs.png#right" width="605" height="448" alt="Recipe docs from the Postgres cookbook"></img>

## Choosing Your Cookbook: Data Bags

Data bag support was added to Chef Solo awhile back -- or you can use them with Chef Zero or Chef Apply. They're a lot like attributes,
and are often stored in JSON files in exactly the same way.

Most of the recipes you want to use will be configured with attributes, not with data bags. But they're basically similar, as long as
you remember that they're usually in separate JSON files.

Similarly, it's best when data bags are documented in the README, but sometimes you need to check the code.

Cookbook code normally uses the search() function to check for databags by name. Which, of course, makes it very hard to grep for
them using a distinctive name. That's another reason to like them less than attributes.

<img src="/images/right_cookbook/mysql-databag.png" width="292" height="98" alt="Code using search() for databags from MySQL cookbook"></img>


## Final Details: Running the Cookbook

If you have Chef Solo or Chef Zero set up, you'll have a list of attributes and a runlist (set of cookbooks to run) set up somewhere, probably in a JSON
file. If you're running via Vagrant, these are "chef.json" and "chef.run_list" in the Chef provisioner.

For Chef with a server this is a bit more complicated, and you'll need to use Knife invocations. See your docs for details.

In MadScience, check your nodes/app-server.json.erb file, which is both the data and the runlist. Add the recipe &mdash; the cookbook should be downloaded
for you automatically without even changing the Cheffile.

If you're <b>not</b> using MadScience, you'll need to download the cookbook. You can do that in a Cheffile or Berksfile if you have one set up, or just
download the cookbook itself and copy it to the appropriate directory, usually called "cookbooks".
