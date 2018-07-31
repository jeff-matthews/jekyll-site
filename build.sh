#!/bin/bash

# debugging
#set -x

# set "fail on error" in bash
set -e

# This command seems to return "HEAD" was the branch name.
# BRANCH=$(git rev-parse --abbrev-ref HEAD)
BRANCH=$(git branch)

if [ "$BRANCH" != "master" ]; then
  echo 'Deploy to a staging directory';
  aws s3 sync _site/ s3://jekyll-site-demo-staging/$BRANCH --delete;

elif [ "$BRANCH" = "master" ]; then
  echo 'Deploy to production';
  aws s3 sync _site/ s3://jekyll-site-demo/ --delete;

fi
