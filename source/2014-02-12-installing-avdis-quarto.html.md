---
title: "Installing Avdi's Quarto"
date: 2014-02-12 20:19
---

I'm trying out <a href="http://avdi.org">Avdi Grimm's</a> <a
href="http://github.com/avdi/quarto">Quarto</a>, a system for turning
Markdown files into books in PDF, ePub and Mobi format. It's an
awesome idea, and Avdi's <a
href="http://www.confidentruby.com/">books</a> always look great.

Of course, Quarto has kind of an intimidating "install me first" list.
Here's what I needed to do:

* I got to skip installing Git. If you need to install it, be sure to
  install XCode as well, which probably needs to happen from the Mac
  App Store these days.

* <tt>brew update</tt>, because I hadn't in awhile.

* Install Pandoc. The package failed, so I had to use <a
  href="brew.sh">Homebrew</a> to <tt>brew install
  haskell-platform</tt>, then <tt>cabal update</tt>, possibly
  <tt>cabal install cabal-install</tt> and finally <tt>cabal install
  pandoc</tt>. Haskell-platform can take 15 minutes to compile. If
  you need to install a new cabal-install (it'll tell you if you do),
  that also takes awhile to compile. You can keep going, though -
  nothing else on this list depends on Pandoc until Quarto itself.

* Install pygments. For me, that meant first installing pip
  (<tt>easy_install pip</tt>), a Python package manager, then <tt>pip
  install pygments</tt>.

* Install xmllint (<tt>brew install libxml2</tt>).

* Download and install <a
  href="http://www.princexml.com/">PrinceXML</a>, the free version.
  Unpacked, ran ./install.sh.

* Install xmlstarlet (<tt>brew install xmlstarlet</tt>).

* Install fontforge (<tt>brew install fontforge</tt>).

* I didn't need to install Ruby or RubyGems. If you do -- well, try
  to make sure you get Ruby 1.9 or higher. This step could be difficult if
  you're not already a Rubyist. We're working on it :-(

* <tt>gem install quarto</tt>

Looks like <a
href="http://blog.firsthand.ca/2013/10/installation-instructions-for-quarto-osx.html">I'm
not the first to notice</a> that Quarto takes some installing :-)

Also looks like Quarto wouldn't be <i>too</i> hard to put together a
Homebrew recipe for.
