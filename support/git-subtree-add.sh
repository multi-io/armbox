#!/usr/bin/env bash
# add a new subtree, or switch an existing subtree to a different branch or remote url.
# Needs to be done once per subtree/branch. Modfied subtrees.txt should be committed afterwards.

set -e

dir="$1"
url="$2"
branch="${3:-master}"

if [ -z "$dir" -o -z "$url" ]; then
    echo "usage: $0 <subdirectory> <giturl> [<branch> (default: master)]" >&2;
    exit 1;
fi

cd "$(dirname $0)/.."

. support/subtrees.sh

echo git subtree add -P "$dir" "$url" "$branch"
git subtree add -P "$dir" "$url" "$branch"

if subtree_set "$dir" "$url" "$branch"; then
    git add "$_st_file"
    git commit --amend --no-edit
fi

support/git-subtree-add-remotes.sh

support/git-subtree-pull-latest.sh "$dir"  # to set up the tracking branch
