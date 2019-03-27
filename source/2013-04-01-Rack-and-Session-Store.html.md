---
title: "Rack and Session Store"
date: 2013-04-01 12:53
disqus_id: "http://codefol.io/posts/40"
---
A fellow asked me how he could store information per-user in Rack. This was my (brief) response:

<hr />

Generally with the cookies object. Specifically, Rack has a "session", which encodes a session identity into the cookies object, usually with some or all of your data.

You can also map from the session ID to data on the server side, with what Rails calls a "session store". Rack comes with a few session stores (cookies, MemCache, pool) and Rails comes with more. Here are some useful links:

* <a href="http://stackoverflow.com/questions/3295083/how-do-i-set-a-cookie-with-a-ruby-rack-middleware-component">How Do I Set a Cookie with a Ruby Rack Middleware Component?</a>

* <a href="http://stackoverflow.com/questions/10451392/how-do-i-set-get-session-vars-in-a-rack-app">How Do I Get Session Variables In Rack?</a>

* <a href="https://github.com/rack/rack/tree/master/lib/rack/session">GitHub: Rack Session Types</a>

* <a href="http://guides.rubyonrails.org/action_controller_overview.html#session">ActionController: Sessions</a>

