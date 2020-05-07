---
title: "Threads in Ruby"
date: 2014-06-22 14:01
tags: ruby
---
Here's a video about threads in Ruby - how do you code them? What are the problems with them?
I'm planning a few more short videos about Ruby concurrency. I don't think enough people
have a good grasp of the tradeoffs and problems of running more than one chunk of code at
once, in Ruby or in general.

<div id="wistia_lo5qbdugwb" class="wistia_embed" style="width:640px;height:388px;"><div itemprop="video" itemscope itemtype="http://schema.org/VideoObject"><meta itemprop="name" content="Threads in Ruby" /><meta itemprop="duration" content="PT2M57S" /><meta itemprop="thumbnailUrl" content="https://embed-ssl.wistia.com/deliveries/c2d6fe1ec6de33a59e7959c093716a2c3ad03347.bin" /><meta itemprop="contentURL" content="https://embed-ssl.wistia.com/deliveries/60065a36b746dc9b83b97d4a6d106f88ba4de345.bin" /><meta itemprop="embedURL" content="https://embed-ssl.wistia.com/flash/embed_player_v2.0.swf?2013-10-04&autoPlay=false&banner=true&controlsVisibleOnLoad=true&customColor=7b796a&endVideoBehavior=default&fullscreenDisabled=true&mediaDuration=177.333&playButtonVisible=true&showPlayButton=true&showPlaybar=true&showVolume=true&stillUrl=https%3A%2F%2Fembed-ssl.wistia.com%2Fdeliveries%2Fc2d6fe1ec6de33a59e7959c093716a2c3ad03347.bin%3Fimage_crop_resized%3D640x360&unbufferedSeek=true&videoUrl=https%3A%2F%2Fembed-ssl.wistia.com%2Fdeliveries%2F60065a36b746dc9b83b97d4a6d106f88ba4de345.bin" /><meta itemprop="uploadDate" content="2014-06-22T20:55:43Z" /><object id="wistia_lo5qbdugwb_seo" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" style="display:block;height:360px;position:relative;width:640px;"><param name="movie" value="https://embed-ssl.wistia.com/flash/embed_player_v2.0.swf?2013-10-04"></param><param name="allowfullscreen" value="true"></param><param name="bgcolor" value="#000000"></param><param name="wmode" value="opaque"></param><param name="flashvars" value="autoPlay=false&banner=true&controlsVisibleOnLoad=true&customColor=7b796a&endVideoBehavior=default&fullscreenDisabled=true&mediaDuration=177.333&playButtonVisible=true&showPlayButton=true&showPlaybar=true&showVolume=true&stillUrl=https%3A%2F%2Fembed-ssl.wistia.com%2Fdeliveries%2Fc2d6fe1ec6de33a59e7959c093716a2c3ad03347.bin%3Fimage_crop_resized%3D640x360&unbufferedSeek=true&videoUrl=https%3A%2F%2Fembed-ssl.wistia.com%2Fdeliveries%2F60065a36b746dc9b83b97d4a6d106f88ba4de345.bin"></param><embed src="https://embed-ssl.wistia.com/flash/embed_player_v2.0.swf?2013-10-04" allowfullscreen="true" bgcolor=#000000 flashvars="autoPlay=false&banner=true&controlsVisibleOnLoad=true&customColor=7b796a&endVideoBehavior=default&fullscreenDisabled=true&mediaDuration=177.333&playButtonVisible=true&showPlayButton=true&showPlaybar=true&showVolume=true&stillUrl=https%3A%2F%2Fembed-ssl.wistia.com%2Fdeliveries%2Fc2d6fe1ec6de33a59e7959c093716a2c3ad03347.bin%3Fimage_crop_resized%3D640x360&unbufferedSeek=true&videoUrl=https%3A%2F%2Fembed-ssl.wistia.com%2Fdeliveries%2F60065a36b746dc9b83b97d4a6d106f88ba4de345.bin" name="wistia_lo5qbdugwb_html" style="display:block;height:100%;position:relative;width:100%;" type="application/x-shockwave-flash" wmode="opaque"></embed></object><noscript itemprop="description">Threads in Ruby</noscript></div></div>
<script charset="ISO-8859-1" src="//fast.wistia.com/assets/external/E-v1.js"></script>
<script>
wistiaEmbed = Wistia.embed("lo5qbdugwb");
</script>
<script charset="ISO-8859-1" src="//fast.wistia.com/embed/medias/lo5qbdugwb/metadata.js"></script>

I'm also still learning <a href="http://www.techsmith.com/camtasia.html">Camtasia</a> and
the rest of the video toolchain. So I hope I'll look back in a few months and think,
"wow, this looks really bad now!"

In the mean time, enjoy! Here's a transcript:

<pre>
Ruby supports threads, of course. Modern Ruby, anything 1.9 and higher, uses
the normal kind of threads for your operating system, or JVM threads if you’re
using JRuby.

[next slide]

Here’s the code to make that happen.

The code inside the Thread.new block runs in the thread, while your main
program skips the block and runs the join. “Join” means to wait for the
thread to finish - in this case, it waits up to 30 seconds since that’s what
we told it. With no argument, join will wait forever.

You’ll probably want a begin/rescue/end inside your thread to print a message
if an uncaught exception happens. By default, Ruby just lets the thread die
silently. Or you can set an option to have Ruby kill your whole program, but I
prefer to print a message.

In “normal” Ruby, Matz’s Ruby, there’s a Global Interpreter Lock. Two threads
can’t run Ruby code at the same time in the same process. So most Ruby threads
are waiting for something to complete, like an HTTP request or a database
query.

[next slide]

What are Ruby threads good for if there’s a global lock? In Matz’s Ruby,
you’ll mostly want to use them for occasional events. RabbitMQ messages,
timeouts, and Cron-style timed jobs are all good.

Since you can only have one thread doing real work in Ruby at once, threads
are best when your process is mostly idle.

JRuby and Rubinius users can chuckle here. Their Ruby handles multiple Ruby
threads working at the same time without a hiccup.

So what problems do you sometimes see with Ruby threads?

[next slide]

With the Global Interpreter Lock, threads can switch back and forth between
CPUs, sometimes very often. If you see Ruby threads performing horribly in
production with Matz’s Ruby or using way too much CPU, try locking the thread
down to a single CPU. Your operating system has commands for that — Google
them.

Next, if the main thread dies or finishes, your program ends. That’s a
feature, but sometimes it’s surprising. To have your main thread of execution
stick around, use join on the other threads to let them finish.

And of course an unhandled exception in a child thread kills only the child
thread, and it does it completely silently. Use a begin/rescue/end to print
errors to console or set the Ruby option to kill the main program when a child
thread dies from an unhandled exception.
</pre>
