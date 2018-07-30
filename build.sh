#!/bin/bash

# debugging
#set -x

# set "fail on error" in bash
set -e

BRANCH=$(git rev-parse --abbrev-ref HEAD)

if [ "$BRANCH" != "master" ]; then
  echo 'Deploy to a staging directory';
  aws s3 sync _site/ s3://jekyll-site-demo-staging/$BRANCH --delete;

elif [ "$BRANCH" = "master" ]; then
  echo 'Deploy production';
  aws s3 sync _site/ s3://jekyll-site-demo/ --delete;

fi
