#!/bin/bash

srcpath="$1"

srcbasedir=src/main/adoc
tgtbasedir=build/html
rootdir="$(pwd)"

tgtpath="$(echo "$srcpath" |
  perl -pe 's#^\Q'"$rootdir"'\E\/##;
            s#^\Q'"$srcbasedir"'\E#'"$tgtbasedir"'#;
            s#\.adoc$#.html#')"
tgtdir="$(dirname "$tgtpath")"
mkdir -p "$tgtdir"

set -x
asciidoc -o "$tgtpath" "$srcpath"

