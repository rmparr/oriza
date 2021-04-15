#!/bin/bash

cd `git rev-parse --show-toplevel`
mix format --check-formatted
if [ $? == 1 ]; then
  echo "commit failed due to format issues..."
  exit 1
fi
