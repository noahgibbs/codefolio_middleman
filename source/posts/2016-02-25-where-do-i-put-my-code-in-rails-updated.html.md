---
title: "Where Do I Put My Code In Rails (Updated)"
date: 2016-02-25 18:23
mc_signup: rails
tags: rails, rebuildingrails, favourite
---

Lots of you loved my <a href="http://codefol.io/posts/Where-Do-I-Put-My-Code">old post</a> on this. Thanks! But thanks to many fine questions,
especially by <a href="https://twitter.com/bsgreenb">one guy on Twitter</a>, it's time for an update! And also, naturally,
the same things you loved last time. I'm not <i>heartless</i>.

Sometimes you’re <i>sure</i> that’s not the right place for that piece of code, but where <i>does</i> it go? "Refactor" is only a good answer if you know how to fix it.

In a Rails application, what kind of code goes where?

### Models

For code about your database or <a
href="http://c2.com/cgi/wiki?DomainObject">domain objects</a>, the
model is your first stop in Rails. Models are powerful, easy to test,
reusable across applications and more like non-Rails code than most of
Rails -- familiar, even if you don’t know Rails yet.

If there's a good way to put the code in your model, that's usually a
safe bet and a good idea.

Write tests for them too, of course! The model is also the easiest
part of Rails to test.

With models, also remember that there's no requirement that they be
based on ActiveRecord. It's fine for them to use a different data
store (e.g. Redis, Cassandra, files.) It's also fine for them to only
exist in memory, or be loaded from a service API (e.g. Stripe) or
created and sent to one (e.g. a MailGun mailer.)

### Controllers

It’s easy to put lots of code in your controllers, but it’s <a
href="http://weblog.jamisbuck.org/2006/10/18/skinny-controller-fat-model">almost
always a mistake</a>. Business logic for your app should get out of
the controller and into the model as quickly as possible. Logic about
how things are shown to the user should go into the view or the view
helpers. In general, the controller should be a tiny, thin glue layer
putting together your other components.

A controversial but often good idea is to set exactly one instance
variable in your controller to use in your view. That enforces
single-purpose controller actions and single-purpose views... Which
can be good or bad.

It also sometimes encourages dubious workarounds like serving a single
"background" page that only loads a lot of AJAX requests, each one
single-purpose, from the server. That's architecturally clean, but can
also be very slow. More to the point, it's kind of a weird thing to
force because it's "clean."

### Views

Having lots of logic in your views is a huge anti-pattern. Don’t do
it. It’s hard to test, it’s hard to find, it’s hard to write
sandwiched in between the HTML... Just don’t.

Instead, your views should contain HTML, variables that turn into
HTML, and calls to helper methods that generate HTML &mdash; or
whatever your final output format is. There should be no logic in
there <i>to</i> test. No conditionals, minimal loops, no non-display
methods. If you add an output format, there should be no code to
repeat because all the interesting data transforms already happened,
and no other output format cares about your HTML-only helpers. Right?

You'll see loops used semi-frequently for lists, including lists of
Partials (see later on.) That's basically okay, but not great. The
less logic, the better. Logic doesn't just move code into a
hard-to-test place. It also encourages the next programmer (like you
in the future) to do it wrong too.

### Mailers

In Rails, Mailers are basically views that output email instead of
HTML. That means that in terms of testing, code organization and
helpers, they basically work the same way.

There's some argument about this, and Rails code organization for
mailers varies a bit. But when working it out, try to mostly think of
it as a different view with the same kind of controller action and
most things work themselves out.

### Partials

If you have a repeated chunk of HTML that gets used multiple places,
such as blog-style comments, forms for frequent objects or decorations
around a page column, it can make sense to embed them in a <a
href="https://richonrails.com/articles/partials-in-ruby-on-rails">Partial</a>.

See the <a
href="http://guides.rubyonrails.org/layouts_and_rendering.html">Rails
documentation for Partials</a> for details, but they even allow lists
of objects to render the partial repeatedly (see "rendering
collections" at the link above), which can eliminate pesky loops from
your view code. Partials can nest other view code or other partials as
well.

The big time *not* to use Partials when it seems like you should is
for the very top-level organization of the page. For that, use a <a
href="http://guides.rubyonrails.org/layouts_and_rendering.html">Layout</a>.

### Helpers

Rails "helpers" are very specifically view helpers. They’re
automatically included in views, but <i>not</i> in controllers or
models. That’s on purpose.

Code in the application helper is included in all the views in your
application. Code in other helpers is included in the corresponding
view. If you find yourself writing big loops, method calls or other
logic in the view but it’s clearly display logic, move it into a
method in the helper.

Do you need something like a "controller helper" or "model helper"?
You can put it in a parent class if that makes sense. Or you can put
it into the /lib directory, or any of the alternate places for
lib-type code (see below.)

### Presenters

A sometimes-pattern in Rails applications is presenters -- view-specific
objects that are created by the controller to be passed to the view.

This is another variation on the "controller should only return one
thing" idea above -- what if you return one complex, view-specific
thing that encapsulates many different database models that you
queried? Is that sufficiently "one thing?"

It's an interesting question. But it *does* make it really easy to
encapsulate all your view logic together, so that's nice.

A presenter can be an excellent way to extract a big chunk of logic
used to format several different models together when it's not feeling
like view helpers are a clean solution. You can put them into the view
helpers directories, or under lib, or make a new subdirectory under
app for them -- if you do that last one, make sure to <a
href="http://codefol.io/posts/No-More-Requires">add it to the Rails
search path</a> so that you don't have to require them all explicitly.

### The /lib Directory

Every Rails app starts with a /lib directory, but not much explanation
of it.

Remember that helpers are specifically view helpers? What if you
wanted a controller helper? Or a model helper? Sometimes you can use
a parent controller or parent model, but that’s not always the best
choice.

If you want to write a helper module for non-view logic, the /lib
directory is usually the best place to put it. For example, logging
code or some kinds of error handling may be a cross-cutting concern
like that.

Also, if you're putting everything in the ApplicationController or
ApplicationHelper, those can get big. Consider factoring some of that
code out into helpers, or into modules in /lib.

Stuff in /lib isn’t <a
href="http://codefol.io/posts/No-More-Requires">automagically included
for you</a> like controllers and models. So you'll need to explicitly
require the file like you do in non-Rails Ruby, not just use the name
of the class.

Shared Ruby objects like app-specific Exception types can also go
here.

### Services

Often your Rails application will use Services. That can mean an
external third-party service (e.g. MailGun, a hosted datastore, or
HoneyBadger to catch exceptions.)

In the simplest cases, there's a gem and you can just use it. That's fine.

In the pretty simple cases, there's an obvious way to tie the service in,
such as an error catcher registering itself from an initializer under
config/initializers.

If you'll be dealing with some explicit object from the service, use a
model. This can be an object in an external data store
(e.g. Cassandra column groups, Redis hashes.)

Sometimes you'll deal with a service through a wrapper object
(e.g. the Gibbon API for MailChimp, or the OpenTok wrapper for
WebRTC.) In those cases, the wrapper object can go in a gem, or in the
/lib directory or (better) in a service object under app/service.

Sometimes an external service will produce objects or events. You have
to be careful -- sitting around and receiving events will block your
Rails worker, which can be murder on the response time for a user
waiting in a browser.

Rails actions are really designed for one-and-done handling where you
receive a request and quickly produce a response to it. In general,
this works best when you convert incoming events to HTTP requests or
some similar thing Rails can respond to quickly. And the opposite
direction (start a long-running process) works best when Rails can
farm that out to an external server. See job queues like DelayedJob
for a great example of how to do this.

Services vary a lot, is what I'm saying, and may sometimes not be a
great match for how Rails does things. Rails is specifically designed
around HTTP, and isn't the best application architecture if you have
some not-really-HTTP features like long-running connections,
bidirectional traffic, tight response-time requirements or the need to
always have a browser talk to the same stateful server. Rails is
really poorly designed to act as a World of Warcraft server, for
instance.

### Gems

Sometimes you have reusable pieces in your application. A controller
or model might be needed by multiple different Rails apps. A
particular piece of logic for logging or display might be useful to a
lot of different folks. You might even find <a
href="https://github.com/voxdolo/decent_exposure">a different way of
doing things</a> that most Rails apps would benefit from.

These are all cases where you want to create a new gem and have your
applications use it instead of sharing a directory of code.

(Obviously, you'll also use a lot of third-party gems. I'm not even
counting those right now.)

<a href="http://railscasts.com/episodes/245-new-gem-with-bundler">These
days it’s really easy to create a new gem</a>, so don’t be
intimidated. If you haven’t worked through the first free chapter of
Rebuilding Rails, this may be a good time to do it &mdash; it’ll show
you how to quickly, easily create and use a new gem.

(Brandon Hilkert also has <a href="http://brandonhilkert.com/books/build-a-ruby-gem/">a whole book on the subject</a>!)

### Assets

Often you’re not even writing Ruby code. Instead, it may be Sass,
Scss, JavaScript or CoffeeScript. In that case, it generally belongs
under app/assets.

### Third-Party ("vendor") Code

Sometimes you'll embed third-party code into your app, especially for
older Rails apps. The name Rails uses for such things is "vendor",
which often goes in the path for assets (e.g. jQuery or D3) or gems if
you copy them locally or libraries &mdash; often under lib/vendor or a
similar path.

When you use Bundler to package gems into your app for deployment, it
defaults to using a path with "vendor" in it for the same reason.

The best is not to include third-party code directly in your app,
usually by keeping it in gems. But if you need or want to for some
reason, include "vendor" in the path to let people know that's what
you're doing. Also, don't just edit code in a vendor path. As the name
suggests, keep it in a form that could be downloaded from elsewhere.

### Sanitizing Input

Views (output) have a strong structure with views and view
helpers. And some input from the user can be checked with JavaScript,
though you should never depend on that for security -- savvy users can
skip the JavaScript completely and access your Rails server directly.

So where do you put server-side code to validate or sanitize input?

If it's simple, the controller is fine. A params[:input].strip is fine
right in the controller. As it grows, though, that can fatten up your
nice skinny controllers &mdash; not a good thing.

When it gets larger, you can refactor it into a controller parent
class in some cases, but usually a module in /lib. Rarely it might
want to be a gem. See the /lib section above for more ideas.

Forms are a specific case of this: you want server-side form
validation as well as JavaScript-side form validation. The latter can
often go in the view code, but the former winds up in controllers (if
it's simple) or separate objects, usually in /lib (if it's
complicated) or in a gem (if it's reusable.)

### Jobs and Tasks

Rake tasks are generally put into lib/tasks. That's great for tasks
you'll run from the command line. You'll generally have one or more
"topic" Ruby files organizing your tasks -- the database-related tasks
in one, the payment-related tasks in another, the email-related tasks
in a third file and so on. Rake allows and encourages multiple tasks
per namespace and multiple namespaces per file. <a
href="http://edelpero.svbtle.com/everything-you-always-wanted-to-know-about-writing-good-rake-tasks-but-were-afraid-to-ask">Here's
a pretty good article on organizing Rake tasks</a>.

Job Queue jobs (e.g. DelayedJob, Resque, Sidekiq, Sucker Punch) are
usually put into classes, one file per class. That can clutter things
up a bit. You can also, surprisingly often, make those be rake tasks
as well. In those cases, don't feel limited to one task per file when
it could just be a whole file of "forward these ten job types to these
ten rake tasks."

### Tests

I'm not a huge authority on Rails testing. I'll start by pointing you
<a href="https://robots.thoughtbot.com/rails-test-types-and-the-testing-pyramid">at this
excellent post on ThoughtBot about Rails testing and test types</a>,
which I refer to occasionally.

In general, tests come in multiple flavors &mdash; unit tests are very
specific in what they test, don't find integration bugs, are cheap to
read, write and run and should immediately isolate exactly what the
problem is. On the far other side of the spectrum, integration tests
test <i>everything</i>, are very expensive to read, write and run and
they often only give you a pretty vague idea of what went wrong.

Other tests form a spectrum between them, or just off one side or the
other. That spectrum, in Rails, runs something like:

* Non-Railsy unit tests for plain Ruby objects
* Rails Model tests that mock (fake) all the database access
* Rails Model tests
* Rails Controller tests that don't render views
* Rails Controller tests that check your actual view HTML
* Rails Integration tests
* Cucumber JavaScript tests using Capybara
* Cucumber JavaScript tests using Selenium (driving a real browser)
* "Smoke tests" using REST libraries that you point at a maybe-not-even-local server

Obviously I have not described every possible test configuration, but
I hope it's pretty clear what direction the spectrum runs.

I don't have a strong opinion for how many of which tests you should
have for which projects. Feel free to ask somebody else if you just
want a strong opinion. I tend to think "it depends hugely on the
project." Doing a UI-heavy Rails app with mostly JavaScript? I'd learn
more toward the "integration" end of the spectrum. Writing a small,
tight, API server that only serves JSON? Consider mostly unit tests
with one or two big integration or smoke tests.

If you do this for awhile, you'll get a feel for what you like. Also
for what tests catch production problems fast. Just remember that unit
tests are cheaper, more exact, and catch fewer problems while
integration tests are the opposite. And don't be afraid to have tests
from several different points along the spectrum.

### Concerns, Exceptions and a Conclusion

Rails has a very specific, very unusual setup. I think it’s a good
idea for small apps, but only <a
href="http://evan.tiggerpalace.com/articles/2012/11/21/use-rails-until-it-hurts">use
Rails until it hurts</a>. If your application gets too big or
complicated, the Rails code organization may hurt more than it helps
you.

There are several "grow out of Rails" approaches to apply alternate
architectures to the framework. From <a
href="https://www.agileplannerapp.com/blog/building-agile-planner/refactoring-with-hexagonal-rails">Hexagonal
Rails</a> to <a href="http://objectsonrails.com/">Objects on Rails</a>
to the more general <a href="http://www.clean-ruby.com/">Clean
Ruby</a> DCI approach. I won’t tell you which to use, but I’ll tell
you that you’re better off starting with plain, simple Rails and
growing out of it.

Most Rails apps, and even more Rails controllers, don’t need to get
all that big. They often don’t need to change much. Why go
complicated when simple is working great?
