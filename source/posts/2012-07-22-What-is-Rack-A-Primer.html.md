---
title: "What is Rack?: A Primer"
date: 2012-07-22 23:37
disqus_id: "http://codefol.io/posts/14"
---
Maybe an engineer you respect just told you to go learn about Rack -- you won't get better at Ruby web stuff until you know what's underneath.

Maybe you have to write a config.ru to use <a href="http://heroku.com">Heroku</a> and you're thinking, "what's config.ru?".

Maybe you have a deep, nasty Sinatra bug and you're having to dig into the Sinatra stack traces and stuff that might be failing is named "Rack". Why "Rack"?

Now what?

Now it's time to learn about Rack.

<h2> Quick Answers to "What's Rack?"</h2>

Here are a few things Rack is.

If these don't help, scroll down a bit. There's far more detail below.

<a href="http://rack.github.com">Rack</a> is a nice Ruby-fied replacement for <a href="http://en.wikipedia.org/wiki/Common_Gateway_Interface">CGI</a>.

Rack sits between all the frameworks (Rails, Sinatra, <a href="http://rebuilding-rails.com">Rulers</a>) and all the app servers (thin, unicorn, Rainbows, mongrel) as an adapter.

Rack is a convenient way to build your Ruby app out of a bunch of <a href="http://railscasts.com/episodes/151-rack-middleware">thin layers</a>, like a stack of pancakes. The layers are called middleware. Or pancakes, why not?

<h2> Less Hand-Wavey, Please! </h2>

Your app server (let's say <a href="https://github.com/blog/517-unicorn">unicorn</a>) gets an HTTP request. Somebody wants to post to http://your_site.com/people/127/fire_with_cause (don't worry, it's <a href="http://www.dilbert.com">Wally</a> -- he'll weasel out of it).

Unicorn receives the request, parses it, hands it to Rack, and then Rack gives it to your Sinatra app (or Rails, or Padrino, or <a href="http://rebuilding-rails.com">your framework of choice</a>) as a request, usually a method call. This is where Rails routing takes over, for instance.

Rack keeps Sinatra from having to know anything specific about unicorn. Or mongrel. Or thin. Or lighttpd. Or any of the many other wacky app servers out there. That's why it's like CGI for Ruby.

<h2>But What Good Is It?</h2>

That's fine. But it helps the guys writing app servers, not you. How does Rack help <i>you</i>?

Rack lets you mess with those layers -- the ones above Rails or Sinatra, the ones underneath, and even the ones in the middle! That's the whole "coding your app in thin layers, like a stack of pancakes" thing from up above.

Rails is actually implemented as a whole bunch of Rack pancakes (same as middleware, but I'm calling them pancakes from here on out). Here's what that stack looks like, lightly edited:

```
$ rake middleware
use ActionDispatch::Static
use Rack::Lock
use Rack::Runtime
use Rack::MethodOverride
use ActionDispatch::RequestId
use Rails::Rack::Logger
use ActionDispatch::ShowExceptions
use ActionDispatch::DebugExceptions
use ActionDispatch::RemoteIp
use ActionDispatch::Reloader
use ActionDispatch::Callbacks
use ActiveRecord::ConnectionAdapters::ConnectionManagement
use ActiveRecord::QueryCache
use ActionDispatch::Cookies
use ActionDispatch::Session::CookieStore
use ActionDispatch::Flash
use ActionDispatch::ParamsParser
use ActionDispatch::Head
use Rack::ConditionalGet
use Rack::ETag
use ActionDispatch::BestStandardsSupport
run RailsGame::Application.routes
```

Each of those things is a Rack middleware that's doing a little piece of the processing.

Like Rack::Lock, up near the top? That keeps more than one thread from running in your Rails server at once so that you don't have to make all your code thread-safe.

Or Rails::Rack::Logger? That makes sure your requests get logged to the Rails logfiles.

And what if you added one? Maybe you could fix a lot of nasty bugs with bad HTTP requests if you could just reject them immediately, before they got a chance to screw up your web framework...

Rack ships with a bunch of middlewares and Rails has a bunch of others that it adds. You can even insert your own into the stack if you <a href="http://guides.rubyonrails.org/rails_on_rack.html">mess with config.ru</a> in your Rails app.

A rack pancake can be as simple as <a href="https://www.rubydoc.info/gems/rack/Rack/Config">Rack::Config</a> where you hand it a block of code and it runs it on each request. Or it can be as complex as <a href="http://rackamole.com/">RackAMole</a> which logs every request to a MongoDB instance you have to set up. Or way, way more complex than that.

There are <a href="https://github.com/rack/rack/wiki/List-of-Middleware">lots of fun pancakes</a> out there.

<h2> How Do I Use It?</h2>

Mostly it's done for you. Rails and Sinatra already have Rack support. You can modify config.ru in a Rails/Sinatra/whatever app if you want to <a href="http://railscasts.com/episodes/151-rack-middleware">add Rack pancakes</a> to your app.

But you don't have to do anything at all for basic Rack support if you're already using a Rack framework.

What if you want to write a Rack-based framework and learn all the best tricks? That's a longer answer. Luckily I'm writing a <a href="http://rebuilding-rails.com">book with all those details</a>.

For the first two chapters, sign up below:

