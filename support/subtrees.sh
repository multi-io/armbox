if [ "$(echo $BASH_VERSION | sed 's/^\(.\).*/\1/')" -lt 4 ]; then
    echo "Bash 4 or higher needed" >&2;
    exit 1;
fi

_st_file='support/subtrees.txt'

declare -A subtrees  # map subdirname => "$remote $branch"

while read _dir _url _branch; do
    if [ -n "$_dir" ]; then
        subtrees["$_dir"]="$_url $_branch"
    fi
done <"$_st_file"


subtree_set() {
    local dir="$1"
    local url="$2"
    local branch="$3"

    egrep -q "^$dir $url $branch$" "$_st_file" && return 1
   
    touch "$_st_file"
    sed -i.bak "/^$dir /d" "$_st_file" && rm -f "${_st_file}.bak"
    echo "$dir $url $branch" >> "$_st_file"

    return 0
}
