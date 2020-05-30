#!/bin/bash

function print_help {
    echo "Usage: ha.sh [-t] FILE"
    echo 'Execute commands from FILE in the shell.'
    echo
    echo 'Unlike vanilla Bash,'
    echo '1) Commands in FILE are separated by empty lines,'
    echo '2) Trailing backslashes are not added when splitting a command'
    echo '   across adjacent lines, and'
    echo '3) Comments may be written in any line.'
    echo
    echo 'Option:'
    echo '-t  Translate commands in FILE into vanilla Bash but do not execute.'
}

function remove_comment_lines {
    # Delete all lines beginning with a hash, indented or otherwise.
    sed '/^[[:space:]]*#.*$/d'
}

function remove_inline_comments {
    # Delete from every line
    # 1) the first hash encountered,
    # 2) immediately-preceding whitespace, and
    # 3) all trailing characters.
    sed 's/[[:space:]]*#.*$//g'
}

function add_backslashes {
    # Append a space and backslash to every line that is not
    # 1) an empty line or
    # 2) a line containing only whitespace.
    sed '/^[[:space:]]*$/! s/$/ \\/g'
}

function add_empty_line {
    # Leave an empty line after the last.
    # Ending with a backslash may cause issues on some systems,
    # where that backslash may be interpreted as a literal.
    echo
    # Add a no-op after the empty line that does nothing when executed.
    # It prevents the empty line from being trimmed during command substitution.
    echo :
}

function translate {
    <$1 remove_comment_lines | remove_inline_comments | add_backslashes
    add_empty_line
}

function print_error {
    echo "ha.sh: $1"
    echo
    print_help
}

function check_argument {
    # Exit (function) with status 0 if an argument
    # 1) is passed, and
    # 2) is the name of an existing regular file.
    # Otherwise, complain and exit with status 1.
    if [ ! -z $1 ]; then
        if [ -f $1 ]; then
            return 0
        else
            print_error "$1 is not a regular file"
            return 1
        fi
    else
        print_error "filename argument required"
        return 1
    fi
}

if getopts ':t' FLAG; then
    case $FLAG in
        t)
            if check_argument $2; then
                # Translate but do not execute
                translate $2
            fi
            ;;
        \?)
            print_help
            ;;
    esac
else
    if check_argument $1; then
        # Translate and execute
        eval "$(translate $1)"
    fi
fi
