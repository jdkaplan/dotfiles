source_if() {
    if [ -e "$1" ]; then
        source "$1"
    fi
}

path_if() {
    if [ -d "$1" ]; then
        case ":$PATH:" in
            *:"$1":*)
                ;;
            *)
                PATH="${1}${PATH:+:$PATH}"
        esac
    fi
}

source_if "${HOME}/.nix-profile/etc/profile.d/nix.sh"

path_if "$HOME/bin"
path_if "$HOME/.local/bin"
path_if /usr/local/bin
path_if /opt/homebrew/bin
path_if /opt/homebrew/sbin

unset -f source_if
unset -f path_if
