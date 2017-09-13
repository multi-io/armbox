#!/usr/bin/env bash

set -e

cd "$(dirname $0)/.."

dir="$1"

if [ -z "$dir" ]; then
    echo "usage: $0 <subdirectory>" >&2;
    exit 1;
fi

. support/subtrees.sh
read url branch <<<"${subtrees[$dir]}";

set -x
git subtree split -P "$dir/" -b "$dir-$branch" --rejoin
