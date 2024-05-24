---
layout: horace_page
title: "Start the Rebuilding Rails Email Class"
comments: false
next: false
prev: false
---

Hi! You'd like to (re)start that Rails internals email class, yeah?

<%= partial("newsletter-box") %>

Turns out "click a link in an email" stuff can be a little weird. GMail and friends want to spam-check and prefetch links. Sometimes people forward emails to their friends (thanks for that!)

So the easiest way to handle this is to have you submit a form to start (or re-start) the email class. Nobody submits forms to pre-fetch content. If you forward the email, your friend sees the form and can pick their email address, not yours.
