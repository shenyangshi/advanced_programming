#!/bin/bash
###############################################################################
# Name:          parseargs.sh
# Author:        Brian Borowski
# Last modified: May 23, 2023
# Description:   bash script that shows how to work with getopts and arrays
###############################################################################

# Let this variable act as a boolean.
size_flag=0

# The only valid command line argument is -s.
# The leading colon supresses internal errors messages printed by getopts.
# We'll write our own custom error message for the ? case.
while getopts ":s" option; do
    case "$option" in
       s) size_flag=1
          ;;
       ?) printf "Error: Unknown option '-%s'.\n" "$OPTARG" >&2
          # Script failed.
          exit 1 #echo $? returns the previous errors
          ;;
    esac
done

# Declare an array.
declare -a filenames

# OPTIND gives the position of the next command line argument.
# Removes n strings from the positional parameters list. Thus, shift
# "$((OPTIND-1))" removes all the options that have been parsed by getopts
# from the parameters list. After that point, $1 will refer to the first
# non-option argument passed to the script.
# Suppose you run: ./parseargs.sh -s a.txt b.txt
#
# ./parseargs.sh is $0, -s is $1, a.txt is $2, b.txt is $3.
# We need to shift out all the flags, in this case -s.
# After shifting, a.txt is $1, b.txt is $2.
shift "$((OPTIND-1))"
index=0
# @ expands to the positional parameters, starting from 1. When the expansion
# occurs within double quotes, each parameter expands to a separate string.
for f in "$@"; do
   filenames[index]="$f"
   (( ++index ))
done

if [ $size_flag -eq 1 ]; then
   echo "Size flag is enabled."
fi
if [ ${#filenames[*]} -gt 0 ]; then #lt: less than, lte; less than and equal
    echo "${filenames[*]}"
fi

# Script succeeded.
exit 0