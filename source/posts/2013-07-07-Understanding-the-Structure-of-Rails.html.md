---
title: "Understanding the Structure of Rails"
date: 2013-07-07 23:29
disqus_id: "http://codefol.io/posts/46"
---
Ruby on Rails is divided into several separate pieces. If you know what they are and what they do, you can use them individually. You can also look up documentation more easily, and you'll know where to look for source code to a particular method, and which of several similarly-named methods does what you want.

### The Gems

By default Rails includes not one, but five reusable gems. The actual "Rails" gem contains very little code. Instead, it delegates to the supporting gems. Rails itself just ties them together.

Rails allows you to change out many components - you can specify a different ORM, a different testing library, a different Ruby template library or a different JavaScript library. So the descriptions below aren’t always 100% accurate for applications that customize heavily.

Below are the basic Rails gems -- not dependencies or libraries, but the fundamental pieces of Rails itself.

### ActiveSupport

<a href="http://guides.rubyonrails.org/active_support_core_extensions.html">ActiveSupport</a> is a <a href="https://github.com/rails/rails/tree/master/activesupport">compatibility library</a> including methods that aren't necessarily specific to Rails. You'll see ActiveSupport used by non-Rails libraries because it contains such a lot of useful baseline functionality. ActiveSupport includes methods like how Rails changes words from single to plural, or CamelCase to snake_case. It also includes significantly better time and date support than the Ruby standard library.

### ActiveModel

<a href="https://github.com/rails/rails/tree/master/activemodel">ActiveModel</a> hooks into features of your models that aren't really about the database - for instance, if you want a URL for a given model, <a href="http://yehudakatz.com/2010/01/10/activemodel-make-any-ruby-object-feel-like-activerecord/">ActiveModel helps you there</a>. It's a thin wrapper around many different ActiveModel implementations to tell Rails how to use them. Most commonly, ActiveModel implementations are ORMs (see ActiveRecord, below), but they can also use non-relational storage like MongoDB, Redis, Memcached or even just local machine memory.

### ActiveRecord

<a href="http://api.rubyonrails.org/classes/ActiveRecord/Base.html">ActiveRecord</a> is an Object-Relational Mapper (ORM). That means that it maps between Ruby objects and tables in a SQL database. When you <a href="http://guides.rubyonrails.org/active_record_querying.html">query from or write to the SQL database in Rails</a>, you do it through ActiveRecord. ActiveRecord also implements ActiveModel. ActiveRecord supports MySQL and SQLite, plus JDBC, Oracle, PostgreSQL and many others.

### ActionPack

<a href="https://github.com/rails/rails/tree/master/actionpack">ActionPack does routing</a> - the mapping of an incoming URL to a controller and action in Rails. It also sets up your controllers and views, and shepherds a request through its controller action and then through rendering the view. For some of it, ActionPack uses Rack. The template rendering itself is done through an external gem like <a href="http://www.kuwata-lab.com/erubis/">Erubis for .erb templates</a>, or <a href="http://haml.info/">Haml for .haml templates</a>. ActionPack also handles action- or view-centered functionality like view caching.

### ActionMailer

<a href="http://api.rubyonrails.org/classes/ActionMailer/Base.html">ActionMailer</a> is used to <a href="http://guides.rubyonrails.org/action_mailer_basics.html">send email</a>, especially email based on templates. It works a lot like you'd hope Rails email would, with controllers, actions and "views" - which for email are text-based templates, not regular web-page templates.

### Tying It Up

There's one more gem, called "rails", that ties these all together via something called "RailsTies".

You can <a href="https://github.com/rails/rails/tree/master/railties">read the code if you like</a> -- it's quite short.

Basically, something has to put all these pieces together. Your app has some glue code to do this &mdash; try typing "rails new myapp", and read through the config directory for a sample. But the rest is done by RailTies.

### Now You Know

Knowing what part of Rails does what is a great way to figure out where to find code and documentation. And finding code and documentation is a great way to understand what Rails is doing.

