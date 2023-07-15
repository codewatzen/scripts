#!/bin/bash
# A script I created back when learning cmd, I updated that script to powershell and now updated the script to bash.

dir=~/Downloads/

# Iterate through each file in the directory
for filename in "$dir"*; do
    base=${filename%.*}   # Extract the base name of the file (without extension)
    ext=${filename##*.}   # Extract the extension of the file
    extDir="${dir}${ext}" # Create the target directory path using the extension

    echo "$filename" # Print the current file path
    echo "$base"     # Print the base name of the file
    echo "$ext"      # Print the file extension

    if [ -d "$extDir" ]; then
        # If the target directory already exists, move the file into it
        echo "Moving $filename to $extDir"
        mv "$filename" "$extDir"
    else
        # If the target directory doesn't exist, create it and then move the file into it
        echo "$extDir doesn't exist, creating directory"
        mkdir -p "$extDir"
        echo "Moving $filename to $extDir"
        mv "$filename" "$extDir"
    fi
done