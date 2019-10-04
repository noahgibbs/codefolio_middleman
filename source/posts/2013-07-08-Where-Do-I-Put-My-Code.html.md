---
title: "Where Do I Put My Code?"
date: 2013-07-08 01:23
disqus_id: "http://codefol.io/posts/48"
---

(Hey! There's a <a href="http://codefol.io/posts/where-do-i-put-my-code-in-rails-updated">great, expanded, new version of this post. Go there instead!</a>)

Sometimes you’re <i>sure</i> that’s not the right place for that piece of code, but where <i>does</i> it go? "Refactor" is only a good answer if you know how to fix it.

In a Rails application, and what kind of code goes where?

### Models

For code about your database or <a href="http://c2.com/cgi/wiki?DomainObject">domain objects</a>, the model is your first stop in Rails. Models are powerful, easy to test, reusable across applications and more like non-Rails code than most of Rails -- familiar, even if you don’t know Rails yet.

If there's a good way to put the code in your model, that's usually a safe bet and a good idea.

Write tests too, of course!

### Controllers

It’s easy to put lots of code in your controllers, but it’s <a href="http://weblog.jamisbuck.org/2006/10/18/skinny-controller-fat-model">almost always a mistake</a>. Business logic for your app should get out of the controller and into the model as quickly as possible. Logic about how things are shown to the user should go into the view. In general, the controller should be a tiny, thin glue layer putting together your other components.

### Views

Having lots of logic in your views is a huge anti-pattern. Don’t do it. It’s hard to test, it’s hard to find, it’s hard to write sandwiched in between the HTML... Just don’t.

Instead, your views should contain HTML, variables that turn into HTML, and calls to helper methods that generate HTML &mdash; or whatever your final output format is. There should be no logic in there <i>to</i> test. No conditionals, no loops, no non-display methods. If you add an output format, there should be no code to repeat because all the interesting data transforms already happened, and no other output format cares about your HTML-only helpers. Right?

### Helpers

Rails "helpers" are very specifically view helpers. They’re automatically included in views, but <i>not</i> in controllers or models. That’s on purpose.

Code in the application helper is included in all the views in your application. Code in other helpers is included in the corresponding view. If you find yourself writing big loops, method calls or other logic in the view but it’s clearly display logic, move it into a method in the helper.

### The /lib Directory

Every Rails app starts with a /lib directory, but not much explanation of it.

Remember that helpers are specifically view helpers? What if you wanted a controller helper? Or a model helper? Sometimes you can use a parent controller or parent model, but that’s not always the best choice.

If you want to write a helper module for non-view logic, the /lib directory is usually the best place to put it. For example, logging code or some kinds of error handling may be a cross-cutting concern like that.

Also, if you're putting everything in the ApplicationController or ApplicationHelper, those can get big. Consider factoring some of that code out into helpers, or into /lib.

Stuff in /lib isn’t always automagically included for you like controllers and models. So you may need to explicitly require the file, not just use the name of the class.

### Gems

Sometimes you have reusable pieces in your application. A controller or model might be needed by multiple different Rails apps. A particular piece of logic for logging or display might be useful to a lot of different folks. You might even find <a href="https://github.com/voxdolo/decent_exposure">a different way of doing things</a> that most Rails apps would benefit from.

These are all cases where you want to create a new gem and have your applications use it instead of sharing a directory of code.

<a href="http://railscasts.com/episodes/245-new-gem-with-bundler">These days it’s really easy to create a new gem</a>, so don’t be intimidated. If you haven’t worked through the first free chapter of Rebuilding Rails, this may be a good time to do it &mdash; it’ll show you how to quickly, easily create and use a new gem.

### Assets

In a few cases, you’re not even writing Ruby code. Instead, it may be Sass, Scss, JavaScript or CoffeeScript. In this case, it generally belongs under app/assets.

### Concerns and Exceptions

Rails has a very specific, very unusual setup. I think it’s a good idea for small apps, but only <a href="http://evan.tiggerpalace.com/articles/2012/11/21/use-rails-until-it-hurts">use Rails until it hurts</a>. If your application gets too big or complicated, the Rails code organization may hurt more than it helps you.

There are several "grow out of Rails" approaches to apply alternate architectures to the framework. From <a href="https://www.agileplannerapp.com/blog/building-agile-planner/refactoring-with-hexagonal-rails">Hexagonal Rails</a> to <a href="http://objectsonrails.com/">Objects on Rails</a> to the more general <a href="http://www.clean-ruby.com/">Clean Ruby</a> DCI approach. I won’t tell you which to use, but I’ll tell you that you’re better off starting with plain, simple Rails and growing out of it.

Most Rails apps, and even more Rails controllers, don’t need to get all that big. They often don’t need to change much. Why go complicated when simple is working great?
