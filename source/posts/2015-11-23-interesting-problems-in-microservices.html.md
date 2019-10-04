---
title: "Interesting Problems in Microservices"
date: 2015-11-23 20:54
---

Breaking down a giant monolithic Rails app (colloquially a "monorail") is a very hot topic right now. I'll give you the boring, accepted advice first: extract obvious bits by breaking apart obvious sub-apps, take nontrivial logic and extract it into /lib and/or external gems, take repetitive models/controllers/views and, if possible, extract those into separate Rails-specific gems ("engines") as well.

There's compromise in all of that, but it's all basically solid advice. It only takes you so far, but it's clearly in the direction of better code.

So let's talk about some of the newer, less-accepted and dodgier advice, since you're probably already quite familiar with the previous boring advice :-)

You can break back-end stuff into separate services, then call to them via HTTP from the front end. This is higher-latency but scales better, and lets you build not-specifically Railsy logic *outside* of Rails, where it belongs. This is an especially good choice if you have components that don't fit clearly into an HTTP server, such as those that want to run their own threads, processes and/or background jobs. That's the SOA bit, which is called "microservices" if you're hip and/or the services are smallish.

Microservices/SOA adds a bunch of interesting issues, though:

1) how do you deploy them? Separately or together?
2) how do you make sure services are running locally on your dev box?
3) the more processes you have, the more likely one died. How do you keep them all running? Same in prod vs dev or different?
4) how do you handle versioning in the API? How do you handle non-backward-compatible upgrades in services?
5) how do the services communicate? HTTP is inefficient, latency-heavy and error-prone, but message-passing is complex and has ugly failure cases.

That's not all the issues, but it's a good start. We're doing the same at my job, so it's front-of-mind :-)

You're better off if you look for one piece that's already pretty separable and make it its own service first. Then slowly extract others after it's up and working. That lets you ease into a lot of the issues above. It also lets you answer the questions when you need a specific answer, not a general one. One of the big advantages of services is that you can answer these questions in the way that works best for a specific service -- which means it's not always the same answer for each service.

Hope this helps!
