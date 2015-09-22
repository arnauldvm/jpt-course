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

build_options="$(head -1 "$srcpath" |
  perl -pe 's#^//\s*build_options:\s*(.*)\s*$#$1# or $_=""')"

set -x
asciidoc $build_options -o "$tgtpath" "$srcpath"

