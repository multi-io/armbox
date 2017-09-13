#!/usr/bin/env bash

set -e

dir="$1"

if [ -z "$dir" ]; then
    echo "usage: $0 <subdirectory>";
    exit 1;
fi

cd "$(dirname $0)/.."

. support/subtrees.sh
read url branch <<<"${subtrees[$dir]}";

git fetch "${1}-origin" $branch:$dir-$branch
