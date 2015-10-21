#!/bin/bash


find src/main/adoc -type f -name '*.adoc' | sort | perl -pe 's/^(.*)$/include::\1\[\]/' |\
  asciidoc -a icons -d book -a toc2! -s -a numbered -o - - | \
  wkhtmltopdf toc - target/pdf/jpt-bundle.pdf

