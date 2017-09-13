#!/usr/bin/env bash
# initialize git remotes that the other git-* scripts rely on.
# Needs to be done only once

set -e

cd "$(dirname $0)/.."

dir="$1"

if [ -z "$dir" ]; then
    echo "usage: $0 <subdirectory> [<branch>]" >&2;
    exit 1;
fi

./support/git-subtree-fetch-latest.sh "$dir"

. support/subtrees.sh
read url branch <<<"${subtrees[$dir]}";

branch="${2:-$branch}"

echo git subtree pull -P "$dir" "$url" "$branch"
git subtree pull -P "$dir" "$url" "$branch"

if subtree_set "$dir" "$url" "$branch"; then
    git add "$_st_file"
    git commit --amend --no-edit
fi

