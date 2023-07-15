#!/bin/bash

check="hevc"
x265="<x265 directory folder>"
dir="<Unmanic Compressed folder>"
dir1="<Unmanic working folder1>"
dir2="<Unmanic working folder2>"
dir3="<Original files folder>"

# Function called x265_folder that checks if $x265 path exists and if it doesn't it creates it
x265_folder() {
    if [ ! -d "$x265" ]; then
        echo "$x265 doesn't exist, creating now"
        mkdir "$x265"
    fi
}

# Function called search_directory that uses the $movie variable to search for a file in a given directory ($1)
# If the file exists, it will move the file to $dir3
search_directory() {
    local directory=$1
    search=$(fdfind "$movie" "$directory")
    if [ -z "$search" ]; then
        echo "$movie was not found in '$directory'"
    else
        mv "$search" "$dir3/"
    fi
}

# Runs x265_folder function and starts the For loop parsing out files from $dir
x265_folder
for file in "$dir"*; do
    # Takes the $file variable and extracts just the name and puts it in the $movie variable
    movie=$(basename "${file% (*}")
    # Starts the If statement check if $file is a file
    if [[ -f "$file" ]]; then
        # Creates variable $codec that contains ffprobe output of the codec_name from $file
        codec=$(ffprobe -hide_banner -v error -select_streams v:0 -show_entries stream=codec_name "$file")
        # Starts another If statement checking if $codec equals $check hevc = hevc
        if [[ "$codec" == *"$check"* ]]; then
            # If the check is correct, it echoes that the $movie was converted, moves $file to $x265
            # then runs both search_directory functions to move the files from $dir1 and $dir2 to $dir3
            echo "$movie was converted successfully, moving to x265 folder"
            mv "$file" "$x265/"
            search_directory "$dir1"
            search_directory "$dir2"
            chmod -R 777 "$x265" && chown -R <user:group> "$x265"
        else
            # If the check is incorrect it echoes that the $movie wasn't converted properly then removes the file from $dir
            echo "$movie failed to transcode to HEVC"
            rm "$file"
        fi
    fi
done