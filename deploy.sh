#!/bin/bash

set -e
set -x

git push
ssh deployer@madrubyscience.com "PATH=/home/deployer/.rbenv/bin:/home/deployer/.rbenv/shims:$PATH; cd checkouts/codefolio_middleman && git pull && bundle && cd assets && ./process.rb && cd .. && bundle exec middleman build"
