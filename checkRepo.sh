#!/bin/bash

# Original Author: Brandon Rozek
# Website: https://brandonrozek.com/blog/ahead-behind-git/
# Modified by: Askmarkio
# URL: https://github.com/Askmarkio
# version: 1.0.1

set -o errexit
set -o nounset
set -o pipefail

show_usage() {
  echo "Usage: git-remote-status [-R]"
  exit 1
}

check_remote() {
  if [ -d .git ]; then
    git remote update > /dev/null 2> /dev/null
    branch=$(git rev-parse --abbrev-ref HEAD)
    ahead=$(git rev-list --count origin/$branch..$branch)
    behind=$(git rev-list --count $branch..origin/$branch)
    echo "$ahead commits ahead, $behind commits behind"
  else
    echo ""
    echo "This is not a Git repository."  
    echo ""
    echo "Use '-R' to check the folders within this directory."
    echo ""
  fi
}

if [ "$#" -eq 0 ]; then
  check_remote
  exit 0
fi

if [ "$1" != "-R" ]; then 
  show_usage
  exit 1
fi


process() {
  if [ -d "$1/.git" ]; then
    pushd "$PWD" > /dev/null
    cd "$1"
    echo -n "$1 "
    check_remote
    popd > /dev/null
  else
    echo ""
    echo "This is not a Git repository."  
    echo ""
    echo "Use '-R' to check the folders within this directory."
    echo ""
  fi
}
export -f process

find . -type d -depth 1 -print0 | while read -d $'\0' folder
do
  process $folder
done
