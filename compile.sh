#!/bin/bash

force=false
case "$1" in
  -f|--force)
    force=true
    shift
    ;;
esac

#if [ "$1" = "-f" ]; then
#  force=true
#  shift
#fi

srcpath="$1"

srcbasedir=src/main/adoc
tgtbasedir=target/html
tgtpdfbasedir=target/pdf
rootdir="$(pwd)"

tgtpath="$(echo "$srcpath" |
  perl -pe 's#^\Q'"$rootdir"'\E\/##;
            s#^\Q'"$srcbasedir"'\E#'"$tgtbasedir"'#;
            s#\.adoc$#.html#')"

tgtpdfpath="$(echo "$tgtpath" |
  perl -pe 's#^\Q'"$tgtbasedir"'\E#'"$tgtpdfbasedir"'#;
            s#\.html$#.pdf#')"

$force || if [ "$tgtpath" -nt "$srcpath" ]; then
  echo "$tgtpath already exists and is up to date, nothing to do."
  exit
fi

tgtdir="$(dirname "$tgtpath")"
mkdir -p "$tgtdir"

tgtpdfdir="$(dirname "$tgtpdfpath")"
mkdir -p "$tgtpdfdir"

build_options="$(head -1 "$srcpath" |
  perl -pe 's#^//\s*build_options:\s*(.*)\s*$#$1# or $_=""')"

build_options_themed="$build_options --theme volnitsky"

set -x
asciidoc $build_options_themed -o "$tgtpath" "$srcpath"
asciidoc $build_options -b html -a toc2! -a toc -a numbered -o - "$srcpath" | wkhtmltopdf - "$tgtpdfpath"

