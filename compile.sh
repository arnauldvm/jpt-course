#!/bin/bash

srcpath="$1"

tgtdir=build/html
mkdir -p "$tgtdir"

tgtpath="$tgtdir/${srcpath%.adoc}.html"
tgtdir="$(dirname "$tgtpath")"
mkdir -p "$tgtdir"

set -x
asciidoc -o "$tgtpath" "$srcpath"

