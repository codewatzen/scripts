#!/bin/bash
# Bash file I created using fdfind, ffprobe and jq that outputs format size in GB, file name, resolution and codec to a csv
videodirs="<directorie of files>"
csv="<location of csv>"
echo "Size (GB);File Name;Resolution;Codec" >"${csv}"
fdfind -t f -E "*.gz" -E "*.srt" -E "*.sub" . "${videodirs}" \
    -x ffprobe -v quiet -print_format json -show_format -select_streams v:0 \
    -show_entries stream \
    -i | jq --raw-output '. | "=\(.format.size)/1073741824;\((.format.filename | sub(".+(?=\/).";"")));\(.streams[0].width)x\(.streams[0].height);\(.streams[0].codec_name)"' >>"${csv}"
