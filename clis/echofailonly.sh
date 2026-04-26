#!/bin/bash
if [ $# == 0 ]; then exit 1; fi
out=$(mktemp)
$* 2>&1 > $out
returned=$?
if [ $returned != 0 ]; then cat $out; fi
rm $out
exit $returned
