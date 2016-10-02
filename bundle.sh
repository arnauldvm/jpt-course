#!/bin/bash


files=$(find target/html -type f -name '*.html' | sort)
wkhtmltopdf --title "Java Performance Tuning" --outline --footer-right "Page [page] of [toPage]" toc \
  $files \
  target/pdf/jpt-bundle0.pdf

