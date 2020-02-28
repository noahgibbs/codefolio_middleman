#!/bin/bash

set -e
set -x

git push || echo "Git push failed..."
ssh noah@173.230.151.8 ". ~/.bash_profile && cd checkouts/codefolio_middleman && git pull && bundle && bundle exec middleman build"
