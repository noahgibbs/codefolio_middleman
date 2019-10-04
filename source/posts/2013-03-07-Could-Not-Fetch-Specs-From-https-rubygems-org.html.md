---
title: "Could Not Fetch Specs From https://rubygems.org/"
date: 2013-03-07 18:32
disqus_id: "http://codefol.io/posts/35"
---
Are you getting this error from Bundler?

Short version: if using rvm, do this:
    rvm pkg install openssl
    rvm reinstall all --force --with-openssl-dir=$rvm_path/usr"

Want to know what went wrong?

You could edit the live copy of lib/bundler/fetcher.rb to print out the exception -- and when you do, you might see it's a "bad ecpoint" problem in OpenSSL.

You won't have much luck Googling it, because it only happens when internal OpenSSL code fails in an obscure way, in assembly, only on certain versions of GCC on the Mac.

If that happens, switch to a less-bad version of OpenSSL. You may (or may not) have luck installing the Homebrew version and configuring Ruby to use it.

But I use RVM, so I'll suggest "rvm pkg install openssl", then "rvm reinstall all --force --with-openssl-dir=$rvm_path/usr".

That will pull down 1.0.1c, an RVM-approved version of OpenSSL. The second command rebuilds all your rubies so you'll actually use it.
