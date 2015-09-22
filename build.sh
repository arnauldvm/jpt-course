#!/bin/bash

find src/main/adoc -type f -name '*.adoc' | xargs -n1 ./compile.sh

