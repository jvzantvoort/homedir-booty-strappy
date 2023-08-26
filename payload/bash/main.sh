#!/bin/bash

find "$(dirname "$(readlink -f "$0")")" \
    -maxdepth 1 \
    -mindepth 1 \
    -type f \
    -name '*.sh' \
    -executable \
    -not -name 'main.sh' \
    -not -name 'functions.sh' | \
    sort | \
    while read -r target
    do
        "${target}"
    done

