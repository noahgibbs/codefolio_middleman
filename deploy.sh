#!/bin/bash

set -e
set -x

git push
ssh noah@173.230.151.8 ". ~/.bash_profile && cd checkouts/codefolio_middleman && git pull && bundle && cd assets && ./process.rb && cd .. && bundle exec middleman build"
