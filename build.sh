#!/bin/bash

# debugging
set -x

# set "fail on error" in bash
set -e

# This succeeds, but results in a detached head since CodeBuilde appears to be checking out the commit SHA. This returns "HEAD" as the branch name and uploads files to a HEAD directory in S3.
BRANCH=$(git rev-parse --abbrev-ref HEAD)
# Identify the SHA, then ID the branch. Could be problematic if the SHA belongs to multiple branches...
# COMMIT=$(git rev-parse --verify HEAD)
# BRANCH=$(git branch --contains $COMMIT | grep \* | cut -d ' ' -f2)

if [ "$BRANCH" != "master" ]; then
  echo 'Deploy to a staging directory';
  aws s3 sync _site/ s3://jekyll-site-demo-staging/$BRANCH --delete;

elif [ "$BRANCH" = "master" ]; then
  echo 'Deploy to production';
  aws s3 sync _site/ s3://jekyll-site-demo/ --delete;

fi
