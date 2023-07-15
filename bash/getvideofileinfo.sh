#!/bin/bash
# Bash script to output video format details to a CSV file using fdfind, ffprobe, and jq
videodirs="<directory of files>"
csv="<location of csv>"

# Define the header line of the CSV file
header="Size (GB);File Name;Resolution;Codec"

# Write the header to the CSV file
echo "$header" >"$csv"

# Find video files using fdfind, run ffprobe, extract relevant details using jq, and append to the CSV file
fdfind -t f -E "*.gz" -E "*.srt" -E "*.sub" . "$videodirs" \
    -exec bash -c "ffprobe -v quiet -print_format json -show_format -select_streams v:0 -show_entries stream -i \"$0\" |
    jq --raw-output '. | \"=\(.format.size)/1073741824;\((.format.filename | sub(\".+(?=\/).\";\"\")));\(.streams[0].width)x\(.streams[0].height);\(.streams[0].codec_name)\"'" {} >>"$csv"
