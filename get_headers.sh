#!/bin/sh
# Code for extracting the header files from a C/++ source file
# Useful for reducing the number of recompilations due to header file changes
# Usage: ./get_headers.sh [SOURCE_FILE] [INCLUDE_PATHS...]
# Example: ./get_headers.sh file.cpp src

arguments=("$@")
include_paths="${arguments[@]:1}"

if test -f "$1"; then
    sed -n "s/^[[:space:]]*#[[:space:]]*include[[:space:]]*\"\(.*\)\"/\1/p" $1 |
    while read filename; do
        if test -z "$include_paths"; then
            echo "$(dirname $1)/$filename"
        else
            for path in "$include_paths"; do
                if test -f "$path/$filename"; then
                    echo "$path/$filename"
                    break
                fi
            done
        fi
    done
fi
