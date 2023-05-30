#!/bin/bash
check="hevc"
x265="/mnt/omnitrix/unmanic/compressed/x265"
dir="/mnt/omnitrix/unmanic/compressed/"
dir1="/mnt/omnitrix/unmanic/omni_unmanic/"
dir2="/mnt/omnitrix/unmanic/mxl_unmanic/"
dir3="/mnt/omnitrix/unmanic/old_files"
# Function called x265_folder that checks if $x265 path exists and if it doesn't it creates it
x265_folder() {
    if [ ! -d "${x265}" ]; then
        echo "${x265} doesn't exist creating now"
        mkdir "$x265"
    fi
}
# Function called search_dir1 that uses the $movie varible to search for a file in $dir1 with the same string
# if file exists it will move file to $dir3
search_dir1() {
    search=$(fdfind "$movie" $dir1)
    # -z test for a zero-length string
    if [ -z "$search" ]; then
        echo "$movie was not in 'omni_unmanic'"
    else 
        mv "$search" "$dir3"/
    fi
}
# Function called search_dir1 that uses the $movie varible to search for a file in $dir2 with the same string
# if file exists it will move file to $dir3
search_dir2() {
    search=$(fdfind "$movie" $dir2)
    # -z test for a zero-length string
    if [ -z "$search" ]; then
        echo "$movie was not in 'mxl_unmanic'"
    else
        mv "$search" "$dir3"/
    fi
}
# Runs x265_folder function and starts the For loop parsing out files from $dir
x265_folder
for file in "${dir}"*; do
# Takes the $file variable and extracts just the name and puts it in the $movie variable
    movie=$(basename "${file% (*}") # | rev | cut -c 8- | rev
# Starts the If statement check if $file is a file 
    if [[ -f "${file}" ]]; then
# Creates variable $codec that contains ffprobe output of the codec_name from $file
        codec=$(ffprobe -hide_banner -v error -select_streams v:0 -show_entries stream=codec_name "${file}")
# Starts another If statement checking if $codec equals $check hevc = hevc
        if [[ "$codec" == *"$check"* ]]; then
# If the check is correct, it echos that the $movie was converted, moves $file to $x265 then runs both search_dir1 and search_dir2 functions to move the files from $dir1 and $dir2 to $dir3
            echo "${movie} was converted succesfully, moving to x265 folder"
            mv "${file}" "${x265}"/
            search_dir1
            search_dir2
        else
# If the check is incorrect it echos that the $movie wasn't converted properly then removes the file from $dir
            echo "${movie} failed to transcode to HEVC"
            rm $file
        fi
    fi
done