---
title: "Ruby Performance on Codefol.io"
layout: blog_page
comments: false
next: false
prev: false
---

<img src="/images/codefolio_book_transparent_320_205.png" class="pull-right" width="320" height="205" alt="The Codefol.io logo on a book cover."> </img>

Many Ruby Performance posts here are linked to engineering.appfolio.com - I wrote for that site as AppFolio's Ruby Fellow for many years, and I'm quite happy to link to them.

About Ruby and Rails Performance practically:

* My 2018 RubyKaigi talk was called [Faster Apps, No Memory Thrash](https://www.youtube.com/watch?v=Z4nBjXL-ymI) and was about optimising your Ruby apps for memory, and how Ruby's memory system works in general ([slides](https://bit.ly/kaigi2018-gibbs))
* I was on the [Remote Ruby podcast to talk about Ruby 2.6+ JIT](https://share.transistor.fm/s/81b82ee2)
* [Ruby's Memory Environment Variables - Simpler Than They Look](http://engineering.appfolio.com/appfolio-engineering/2018/6/27/ruby-memory-environment-variables-simpler-than-they-look)
* [Where Does Rails Spend Its Time?](http://engineering.appfolio.com/appfolio-engineering/2019/6/4/where-does-rails-spend-its-time) - an analysis with a profiler of where the Rails framework spends its in-Ruby time
* [Benchmarking Threads vs Processes vs Fibers](http://engineering.appfolio.com/appfolio-engineering/2019/9/4/benchmark-results-threads-processes-and-fibers) - how do the speed of those three compare? How has it changed over time?
* [Measuring Rails Overhead](http://engineering.appfolio.com/appfolio-engineering/2019/4/27/measuring-rails-overhead) - how much overhead *does* using Rails add?
* [Benchmarking Ruby's Heap: malloc, tcmalloc, jemalloc](http://engineering.appfolio.com/appfolio-engineering/2018/2/1/benchmarking-rubys-heap-malloc-tcmalloc-jemalloc) - you'll hear folks recommend alternative allocators as one of the easiest ways to pick up some free speed; short version: I agree
* [CRuby's Memory Slots: See Them, Tweak Them, Make Them Fast](http://engineering.appfolio.com/appfolio-engineering/2018/1/2/how-ruby-uses-memory)
* [The Ruby Global Method Cache](http://engineering.appfolio.com/appfolio-engineering/2018/7/18/rubys-global-method-cache) - including what it is and how to tune it for performance
* [Ruby Method Lookup](http://engineering.appfolio.com/appfolio-engineering/2018/10/2/ruby-method-lookup-rubyvmstat-and-global-state) - an obscure corner of Ruby optimisation, but occasionally useful
* [Rails Ruby Bench](http://engineering.appfolio.com/appfolio-engineering/2018/4/2/rails-ruby-bench-what-and-why) - the Ruby benchmark I wrote, what it is and why you might care
* [OptCarrot: An Excellent CPU Benchmark for Ruby 3x3](http://engineering.appfolio.com/appfolio-engineering/2017/9/22/optcarrot-an-excellent-cpu-benchmark-for-ruby-3x3) - by looking at an existing benchmark, you can think about what to add to yours
* [Building Ruby with Memory Profiling](http://engineering.appfolio.com/appfolio-engineering/2018/1/3/quickie-building-ruby-with-memory-profiling) - not a bad guide to generally building Ruby with modifications
* [Wrk it!](http://engineering.appfolio.com/appfolio-engineering/2019/4/21/wrk-it-my-experiences-load-testing-with-an-interesting-new-tool) - I like [wrk](https://github.com/wg/wrk), as load-testing tools go; here's an explanation

About Benchmarking, Profiling and Performance in general:

* I was on the [Ruby Rogues talking about measuring performance](https://devchat.tv/ruby-rogues/rr-362-measuring-ruby-performance-with-rails-and-discourse-with-noah-gibbs/)
* [What About Warmup?](http://engineering.appfolio.com/appfolio-engineering/2017/5/2/what-about-warmup) - this benchmarking of Ruby warmup shows you some interesting things about warmup in general
* [Can I Use Ten 10% Speedups to Make Ruby Instant?](http://engineering.appfolio.com/appfolio-engineering/2018/7/24/performance-math-and-where-to-find-it) - performance math explained; not Ruby-specific
* [Microbenchmarks vs Macrobenchmarks](http://engineering.appfolio.com/appfolio-engineering/2019/1/7/microbenchmarks-vs-macrobenchmarks-ie-whats-a-microbenchmark) - what different sizes of benchmark can measure
* [Profiling Ruby Like an A/B Tester](http://engineering.appfolio.com/appfolio-engineering/2016/7/18/profiling-ruby-like-an-ab-tester) - using Ruby as an example of why it's important to use statistical tests to validate your optimisations

About Ruby's (or Rails') performance historically:

* Video of my 2019 RubyKaigi talk about [Six Years of Ruby Performance](https://www.youtube.com/watch?v=iy4N7AtzZYc) and how it has changed over that time ([slides](https://www.dropbox.com/s/jfe4yjezpcr2171/RubyKaigiSlides.key?dl=0)); this talk covers both a quick summary of the large Rails app work I'm known for and a deep dive into some simpler benchmarks
* [A Ruby Speed Roundup, 2.0 through 2.6](http://engineering.appfolio.com/appfolio-engineering/2019/3/7/ruby-speed-roundup-20-through-26) - how has Ruby performance changed over time?
* At RubyKaigi 2017, my talk was [How Close is Ruby 3x3 for Real Web Apps?](https://www.youtube.com/watch?v=xZ5mw3x2pdo), which introduced Rails Ruby Bench ([slides](https://bit.ly/kaigi2017-gibbs))
* [Rails and Discourse Startup Times](http://engineering.appfolio.com/appfolio-engineering/2017/8/21/rails-and-discourse-startup-times) - Rails and Discourse startup times examined in historical Ruby versions


Some Fairly Academic Links (not written/spoken by me):

* [Performance Matters, by Emery Berger](https://www.youtube.com/watch?v=r-TLSBdHe1A) (video) - talks about stability in benchmark results, and subtleties thereof
* [Virtual Machine Warmup Blows Hot and Cold](https://arxiv.org/abs/1602.00602) - this dense whitepaper lets you know: warmup isn't cut-and-dried, and often doesn't work like that at all; hat-tip to Chris Seaton for the link
* [Rigorous Benchmarking in Reasonable Time](https://kar.kent.ac.uk/33611/) - another dense whitepaper, this one about how to take benchmarking samples with an eye toward getting a reasonable confidence interval
