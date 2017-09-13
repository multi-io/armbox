#!/bin/sh

set -e

if [ -z "$1" ]; then
    echo "usage: $0 <subdirectory>";
    exit 1;
fi

cd "$(dirname $0)/.."

git push "${1}-origin" "${1}-master:master"
