#!/usr/bin/env zsh

local STORE="${HOME}/.j"
touch $STORE

# TODO: use a path-disallowed character as a separator (instead of a pipe)

function _j_add() {
    local name=$1;
    local dir=${PWD}
    echo "${name}|${dir}" >> "$STORE"
    echo "${name}|${dir}"
}
function _j_delete() {
    local name=$1;
    local regexp="^${name}\|"
    grep -E  "$regexp" "$STORE"
    grep -Ev "$regexp" "$STORE" | sponge "$STORE"
}

function _j_jump() {
    local name=$1;
    local dir=$(grep -E "^${name}\|" "$STORE" | cut -d '|' -f 2)
    if [ -n "$dir" ]; then
        cd "$dir"
    else
        echo "No match found for $name"
    fi
}

function _j_list() {
    cat "$STORE"
}

function j() {
    local action=''
    local action_arg=''

    while [ "$#@" -gt 0 ]; do
        if [ -n "$action" ]; then
            echo "Multiple actions specified"
            return 1
        fi

        case "$1" in
            --add|-a)
                action='_j_add'
                action_arg="$2"
                shift 2
                ;;
            --delete|-d)
                action='_j_delete'
                action_arg="$2"
                shift 2
                ;;
            --list|-l)
                action='_j_list'
                shift
                continue
                ;;
            *)
                action='_j_jump'
                action_arg="$1"
                shift
                continue
                ;;
        esac
    done

    if [ -z "$action" ]; then
        action='_j_list'
    fi

    "$action" "$action_arg"
}
