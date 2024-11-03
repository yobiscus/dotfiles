#!/bin/bash
#
# Swap i3 configuration to specified keyboard layout {qwerty|colemak}
#

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

fatal() {
    echo "Error: $*" >&2
    exit 1
}

main() {
    local layout=$1
    local file

    case "$layout" in
        q|qwerty)   file=qwerty.config     ;;
        c|colemak*) file=colemak.config    ;;
        *)          fatal "Unexpected layout: $layout" ;;
    esac

    ln -sf "$file" "$SCRIPT_DIR/config"
    i3-msg restart
}

main "$@"
