#!/bin/bash

# debugging
#set -x

# set "fail on error" in bash
set -e

# This succeeds, but returns "HEAD" as the branch name and uploads files to a HEAD directory in S3.
# BRANCH=$(git rev-parse --abbrev-ref HEAD)
# This fails
# BRANCH=$(git branch)
# This fails with "fatal: ref HEAD is not a symbolic ref"
# BRANCH=$(git symbolic-ref --short HEAD)
BRANCH=$(git branch | grep \* | cut -d ' ' -f2)

if [ "$BRANCH" != "master" ]; then
  echo 'Deploy to a staging directory';
  aws s3 sync _site/ s3://jekyll-site-demo-staging/$BRANCH --delete;

elif [ "$BRANCH" = "master" ]; then
  echo 'Deploy to production';
  aws s3 sync _site/ s3://jekyll-site-demo/ --delete;

fi
