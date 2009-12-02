#!/bin/bash
#
# The squashed commits in the upstream/master
#   must include the tpoic branch's number as [#1234]
# The topic branch must be named as
#   1234-some-useful-description or just 1234

function usage {
  echo
  echo "Error: $1"
  echo
  echo "    Usage: cleanup-branches.sh /path/to/git/repo"
  echo
  exit
}

if [ -z $1 ]; then
  usage "repo path is not defined."
fi

cd $1

for b in `git br -r  | grep origin`; do 
  bn=`echo $b | cut -d'/' -f2 | cut -d'-' -f1`
  l=`git l upstream/master | grep "\[\#$bn\]"`
  if [ $? -eq 0 ]; then
    echo $b
    echo $l
    git push origin :`echo $b | cut -d'/' -f2`
  fi
done
