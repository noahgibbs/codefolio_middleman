---
title: "Capistrano: Be Sure to Git Push!"
date: 2014-12-11 18:18
tags: deployment
---

<img src="/images/cityscape.png#right" width="401" height="197" alt="Busy debugging at night..." />

(Also known as "why doesn't Capistrano pick up my changes???")

One of the cool things about Capistrano is that you don't even have to put
your Capistrano files into your app repo. You can put the Capfile and
config/deploy.rb and so on in a different repo, or its own repo, or no repo or
whatever.

One of the <b><i>really infuriating</i></b> things about Capistrano is that
it's designed to allow you to do that. See the bottom of this post for a quick
workaround, or just keep reading.

READMORE

Which means that even if you put Capistrano into your app repo, you'll need to
commit <i>and push</i> your changes so that Capistrano can deploy them
wherever they go. This can be a <i>really frustrating</i> edit/debug cycle,
especially if you forget to push for awhile and spend your time shouting
<b>"why doesn't this fix the bug?"</b>

## Workaround

Like many things, the workaround is simple: automation. I'm a big fan of having
a deploy shellscript in my projects and always using it.

Instead of running Capistrano directly ("cap development deploy"), make a
deploy shellscript that runs something like:

<pre>
  git diff-index --quiet HEAD && git push && cap development deploy
</pre>

This makes sure there are no modified files in your Git repo. Then it pushes
your commits to master. <b>Then</b> it deploys.

Do that and you shouldn't have to worry "did I push?"

Then you can get back to real debugging.
