---
title: "What is Rack?: A Primer"
date: 2012-07-22 23:37
disqus_id: "http://codefol.io/posts/14"
tags: rails, rack, rebuildingrails, favourite
---
If you do Ruby web programming, you'll often hear about "Rack." You might hear about it from a Ruby dev you respect, and that you won't get better at Ruby web stuff until you know what's underneath.

Or you might have to write a config.ru to use <a href="http://heroku.com">Heroku</a> and you're thinking, "what's config.ru?". It has roughly the same answer &mdash; it's a file Rack uses to set up your app.

You'll probably wind up debugging at some point and see "rack" repeatedly in your stack traces. Why "Rack?"

Now what?

Now it's time to learn about Rack.

<h2> Quick Answers to "What's Rack?"</h2>

Here are a few things Rack is. (There's far more detail below)

<a href="http://rack.github.com">Rack</a> is a nice Ruby-flavoured replacement for <a href="http://en.wikipedia.org/wiki/Common_Gateway_Interface">CGI</a>.

Rack sits between all the frameworks (Rails, Sinatra, <a href="http://rebuilding-rails.com">Rulers</a>) and all the app servers (thin, unicorn, Rainbows, mongrel) as an adapter.

Rack is a convenient way to build your Ruby app out of a bunch of <a href="https://stackoverflow.com/questions/2256569/what-is-rack-middleware">thin layers</a>, like a stack of pancakes. The layers are called middleware. These days, <i>every</i> Rails app is built out of lots of these thin layers.

<h2> Less Hand-Waving, Please! </h2>

Your app server (let's say [Puma](https://github.com/puma/puma)) gets an HTTP request. It happens to be an HTTP POST to /users/login so they can create a new session and log into the server.

Puma receives the request, parses it, hands it to Rack, and then Rack gives it to your Sinatra app (or Rails, or Padrino, or [your framework of choice](https://rebuilding-rails.com)) as a request, usually a method call. This is where Rails routing takes over, for instance.

Rack keeps Sinatra from having to know anything specific about Puma. Or Unicorn. Or Thin. Or any of the many other wacky app servers out there. That's why it's like CGI for Ruby - CGI keeps your web app from needing to know if it's running with [Apache](https://httpd.apache.org/) or [NGinX](http://nginx.org/) or a different web server.

<h2>But What Good Is It?</h2>

That's fine. But it helps the folks writing app servers, not you. How does Rack help <i>you</i>?

Rack lets you mess with those layers -- the ones above Rails or Sinatra, the ones underneath, and even the ones in the middle! That's the whole "coding your app in thin layers, like a stack of pancakes" thing from up above.

Rails is actually implemented as an extensive stack of Rack middleware. Here's what that stack looks like as of Rails 6.0:

```
$ rake middleware
use ActionDispatch::HostAuthorization
use Rack::Sendfile
use ActionDispatch::Static
use ActionDispatch::Executor
use ActiveSupport::Cache::Strategy::LocalCache::Middleware
use Rack::Runtime
use Rack::MethodOverride
use ActionDispatch::RequestId
use ActionDispatch::RemoteIp
use Sprockets::Rails::QuietAssets
use Rails::Rack::Logger
use ActionDispatch::ShowExceptions
use WebConsole::Middleware
use ActionDispatch::DebugExceptions
use ActionDispatch::ActionableExceptions
use ActionDispatch::Reloader
use ActionDispatch::Callbacks
use ActiveRecord::Migration::CheckPending
use ActionDispatch::Cookies
use ActionDispatch::Session::CookieStore
use ActionDispatch::Flash
use ActionDispatch::ContentSecurityPolicy::Middleware
use Rack::Head
use Rack::ConditionalGet
use Rack::ETag
use Rack::TempfileReaper
run SomeApp::Application.routes
```

Each of those things is a Rack middleware that's doing a little piece of the processing.

Like Rack::SendFile, up near the top? It sends back static files (javascript, CSS, 404.html) without your app having to handle that with a controller action.

Or Rails::Rack::Logger? That makes sure your requests get logged to the Rails logfiles.

And what if you added one? Maybe you could fix a lot of nasty bugs with bad HTTP requests if you could just reject them immediately, before they got a chance to screw up your web framework...

Rack ships with a bunch of middlewares and Rails has a bunch of others that it adds. You can even insert your own into the stack if you <a href="http://guides.rubyonrails.org/rails_on_rack.html">mess with config.ru</a> in your Rails app.

A rack middleware can be as simple as <a href="https://www.rubydoc.info/gems/rack/Rack/Lobster">Rack::Lobster</a> which prints out [a little ASCII-art lobster](https://d33wubrfki0l68.cloudfront.net/87acf19e96af99345110f72d3321d9927a2deb2b/4aa7e/images/blog/2016-11/http_server_lobster.png). Or it can be as complex as <a href="https://github.com/derailed/rackamole">RackAMole</a> which logs every request to a MongoDB instance you have to set up. Or way, way more complex than that.

There are <a href="https://github.com/rack/rack/wiki/List-of-Middleware">lots of fun middlewares</a> out there.

<h2> How Do I Use It?</h2>

Mostly it's done for you. Rails and Sinatra already have Rack support. You can modify config.ru in a Rails/Sinatra/whatever app if you want to <a href="http://railscasts.com/episodes/151-rack-middleware">add Rack pancakes</a> to your app.

But you don't have to do anything at all for basic Rack support if you're already using a Rack framework.

What if you want to write a Rack-based framework and learn all the best tricks? That's a longer answer. Luckily I've written a <a href="http://rebuilding-rails.com">book with all those details</a>.

For the first two chapters, sign up below (or on the sidebar to the right.)
