#!/bin/bash

# debugging
set -x

# set "fail on error" in bash
set -e

if [ -e $1 ]; then
  echo "File $1 already exists!"
else
  echo "baseurl: $CODEBUILD_SOURCE_VERSION" >> $1
fi
