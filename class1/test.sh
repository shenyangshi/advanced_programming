#!/bin/bash

readonly ARCHIVE='gcd_assignments.zip'
readonly TESTSCRIPT='test_gcd.sh'

process_file() {
  echo "Processing $1"

  # Extract the name of the file without extensions

  local base=${1%.*} # except the last extension
  echo "$base"

  local first
  first=$(cut -d'_' -f3 <<< "$base")
  local last
  last=$(cut -d'_' -f2 <<< "$base")

  echo "Author: $first $last"
  local dirname="$last"_"$first"
  mkdir -p "$dirname"
  mv "$1" "$dirname"
  cp "$TESTSCRIPT" "$dirname"

  cd "$dirname" || exit 1
  unzip -o "$1"
  rm "$1"

  bash "$TESTSCRIPT" | tee grade.txt
  cd - > /dev/null || exit 1

}

unzip -o $ARCHIVE

for f in *.zip; do
  if [ "$f" != "$ARCHIVE" ]; then
    process_file "$f"
  fi
done
