---
title: "Rack Authentication Middleware"
date: 2012-07-23 00:00
disqus_id: "http://codefol.io/posts/15"
---
<a href="http://codefol.io/posts/What-is-Rack-A-Primer">Rack</a> comes with a fair bit of built-in middleware that you can use to put together a simple app frame. Unfortunately, <a href="http://rack.rubyforge.org/doc/Rack/Auth/Digest/MD5.html">Rack authentication's documentation is pretty bad</a>, so let's see some simple, self-explanatory examples, shall we?

## Config

We'll need a config.ru file for this, and you'll need Rack installed. Here's how you want config.ru to look, at the beginning:

```
# config.ru
require "rack"

run lambda { |env|
  [200,
    {'Content-Type'=>'text/plain'},
    ["Hello, World!"]
  ]
}
```

This is as simple as Rack apps get. Return success (200), a content-type header that says it's text, and "Hello, World!" &mdash; which has to be in a list because Rack says so.

What's the easiest way to put a password in front of this?

## Simple Middleware

Rack comes with nice simple built-in authentication modules. Here's how you use the Basic auth middleware:

```
require "rack"

use Rack::Auth::Basic, "Hello, World" do |username, password|
  'secret' == password
end

run lambda { |env|
  [200,
    {'Content-Type'=>'text/plain'},
    ["Hello, World!"]
  ]
}
```

The "use" statement says to include the password middleware. You can see that the password is "secret" with any user, so type "secret" as the password in your browser! Just return true if they pass the check or false otherwise.

You can also use Digest authentication with Rack::Auth::Digest::MD5. It wants to pass you the username and have you return the password, which it hashes:

```
require "rack"

# Long random string. Use a better one than this.
opaque = "1234567890"

use Rack::Auth::Digest::MD5, "Hello, World", opaque do |username|
  'secret'
end

run lambda { |env|
  [200,
    {'Content-Type'=>'text/plain'},
    ["Hello, World!"]
  ]
}
```

That looks the same to you... But it doesn't send your password in the clear!

Notice that you have to set an "opaque" -- that's a long secret key which should always be the same for your app. I'd recommend you randomize it, not use "1234567890" :-)

## Authentication

These are the only authentication methods Rack supports. That makes sense -- they're the only authentication methods that most browsers support properly.

Now that you have some decent examples, go forth and authenticate your Rack applications!

What Rack applications? That's anything with Rails, Sinatra or <a href="http://rebuilding-rails.com">your framework of choice</a>, of course!

If you like playing down in the Rack internals, have I mentioned that I'm <a href="http://rebuilding-rails.com">writing a book called "Rebuilding Rails"</a> about that?

