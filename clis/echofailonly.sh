#!/bin/bash
if [ $# == 0 ]; then exit 1; fi
out=$(mktemp)
"$@" > $out 2>&1
returned=$?
if [ $returned != 0 ]; then cat $out; fi
rm $out
exit $returned
