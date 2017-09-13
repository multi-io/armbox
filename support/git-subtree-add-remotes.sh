#!/usr/bin/env bash
# initialize git remotes for the subtrees.
# Needs to be done only after new subtrees are added.

cd "$(dirname $0)/.."

. support/subtrees.sh

for dir in "${!subtrees[@]}"; do
    read url branch <<<"${subtrees[$dir]}";
    echo git remote add "${dir}-origin" "$url";
    git remote add "${dir}-origin" "$url" 2>/dev/null || true;
done
