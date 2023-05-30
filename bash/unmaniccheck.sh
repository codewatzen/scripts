#!/bin/bash
check="hevc"
x265="/mnt/omnitrix/unmanic/compressed/x265/"
dir="/mnt/omnitrix/unmanic/compressed/"
dir1="/mnt/omnitrix/unmanic/omni_unmanic/"
dir2="/mnt/omnitrix/unmanic/mxl_unmanic/"
dir3="/mnt/omnitrix/unmanic/old_files/"
# Function called x265_folder that checks if $x265 path exists and if it doesn't it creates it
x265_folder() {
    if [ ! -d "${x265}" ]; then
        echo "${x265} doesn't exist creating now"
        mkdir "$x265"
    fi
}
# Function called search_dir1 that uses the $base varible to search for a file in $dir1 with the same string
# if file exists it will move file to $dir3
search_dir1() {
    search=$(fdfind "$base" $dir1)
    # -z test for a zero-length string
    if [ -z "$search" ]; then
        echo "Couldn't find file in 'omni_unmanic' folder"
    else
        mv "$search" "$dir3"/
    fi
}
# Function called search_dir1 that uses the $base varible to search for a file in $dir2 with the same string
# if file exists it will move file to $dir3
search_dir2() {
    search=$(fdfind "$base" $dir2)
    # -z test for a zero-length string
    if [ -z "$search" ]; then
        echo "Couldn't find file in 'mxl_unamnic' folder"
    else
        mv "$search" "$dir3"/
    fi
}

x265_folder
for file in "${dir}"*; do
    base=$(basename "${file%.*}") # | rev | cut -c 8- | rev
    if [[ -f "${file}" ]]; then
        codec=$(ffprobe -hide_banner -v error -select_streams v:0 -show_entries stream=codec_name "${file}")
        if [[ "$codec" == *"$check"* ]]; then
            echo "${base} was converted succesfully, moving to x265 folder"
            mv "${file}" "${x265}"
            search_dir1
            search_dir2
        else
            echo "${base} failed to transcode to HEVC"
        fi
    fi
done
