---
title: "Automatic HTTPS JavaScript Redirect"
date: 2012-08-01 03:40
disqus_id: "http://codefol.io/posts/20"
---
Awkwardly, I just emailed out links to <a href="https://rebuilding-rails.com/payment_page.html">pay for Rebuilding Rails</a> with "http://" in front. Like, not "https://".

Not so good. I was immediately called on it by one of my list subscribers, <a href="http://codefol.io/posts/Developers-Are-You-Sure-That-Payment-Page-is-Secure-">using my own words</a>!  Can I just say how much I love you guys for actually paying attention? People on my mailing list rule.

I considered emailing out an abject apology and hoping I never did it again, until it hit me...

"Hey, wait! I should never allow insecure links to that from *anybody*. Can't I just force it https?"

Yup. Here's what I used:

```javascript
    if(window.location.protocol != 'https:') {
      location.href = location.href.replace("http://", "https://");
    }
```

That's not as good as redirecting to https directly in NGinX, which I may also do. But it's a great quick fix, and it makes sure that the mistake will be fixed if it happens again.

