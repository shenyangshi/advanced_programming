#!/bin/bash

# Use these variables as intergers.
directory_count=0
symlink_count=0

# Use other variables as booleans.
directory_flag=0
symlink_flag=0

recurse_dir() {
    # "$1"/*" matches all files except the hidden ones.
    # "$1"/.[!.]*" matches all hidden files.
    for file in "$1"/*; do
        if [ -h "$file" ] && [ $symlink_flag -eq 1 ]; then
            echo "symlink" : "$file" -> $(readlink "$file")
            (( ++symlink_count ))
        fi
        if [ -d "$file" ]; then
            if [ "$directory_flag" -eq 1 ]; then
                echo "directory : $file"
                (( ++directory_count ))
            fi
            recurse_dir "$file"
        fi
    done
}


while getopts ":ds" option; do
    case "$option" in
        d) directory_flag=1
            ;;
        s) symlink_flag=1
            ;;
        ?) echo "Error: Unknown option "-%s" .\n" "$OPTARG" >&2
            exit 1
            ;;
    esac
done



if [ $(( directory_flag + symlink_flag )) -eq 0 ]; then
    echo "Error: No search parameters specified." >&2
    exit 1
fi

shift "$(( OPTIND - 1 ))"

if [ $# -gt 1 ]; then
    echo "Error: Too many arguments." >&2
    exit 1
elif [ $# -eq 0 ]; then
    # If no directory is supplied, use the current directory.
    recurse_dir .
else
    recurse_dir "$1"
fi

if [ "$symlink_flag" -eq 1 ]; then
    if [ "$symlink_count" -eq 1]; then
        echo "1 symbolic link found."
    elif [ "$symlink_count" -eq 0]; then
        echo "0 symbolic link found."
    else
        echo "$symlink_count symbolic links found."
    fi
fi

if [ "$directory_flag" -eq 1 ]; then
    if [ "$directory_count" -eq 1 ]; then
        echo "1 directory found."
    elif [ "$directory_count" -eq 0 ]; then
        echo "0 directory found."
    else
        echo "$directory_count directory found."
    fi
fi

exit 0
