#!/usr/bin/env bash

# Generates an M3U playlist file by scanning a specified directory for files.
# https://github.com/vbachvarov/shell-utilities
#
# License:
# Creative Commons License, https://github.com/vbachvarov/shell-utilities/blob/main/LICENSE
# By using this software you consent to the terms and conditions in the license above.
#
# Copyright 2021, vbachvarov
#

EXCLUDED_EXTENSIONS=(.pls .m3u .wpl .sh .m3u .bmp .jpg .jpeg .git .png .tif .rtf .doc .docx .xls .xlsx .wma .txt .pdf .cue .nfo .bup .sfv .md5 .jar .log .db .torrent .htm .html .css .js .vbs .xml .ifo)

NOW="`date +'%F_%H:%M:%S'`"

DIR=${1:-.}
PL=${2:-generated-playlist-$NOW.m3u}

cat <<EOF
Usage: `basename $0` [ДИРЕКТОРИЯ] [СПИСЪК ЗА ИГРА]
       The generated playlist is in M3U format.

Generating playlist '$PL' for directory '$DIR'
EOF

read -p "Press RETURN, to continue..."


[ ! -f "$PL" ] || { echo "ERROR: The file '$PL' exists. It will not be overwritten." 1>&2; exit 1; }
touch "$PL"    || { echo "ERROR: The file '$PL' could not be written to." 1>&2; exit 2; }
chmod 600 "$PL"

echo "Searching for music. This might take a while depending on the number of files scanned. To abort the operation press Ctrl-C ..."
find "$DIR" -type f >  "$PL"

echo    "Cleaning the playlist of irrelevant file types. This is a quick operation."
echo -n "Removing from the playlist all entries ending with: "
for ext in "${EXCLUDED_EXTENSIONS[@]}"; do
    echo -n "'$ext' "

    sed -i '/\'$ext'$/d' "$PL"

    extUpper="$(echo $ext | awk '{ print toupper($0) }')"
    sed -i '/\'$extUpper'$/d' "$PL"
done
echo ""

echo "Sorting the playlist..."
cat "$PL" | sort -o "$PL"   # This is safe - see sort documentation.

echo "The playlist '$PL' has been generated. rc=$?"
