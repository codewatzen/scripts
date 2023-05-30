#!/bin/bash
# A script I created back when learning cmd, I updated that script to powershell and now updated the script to bash.
dir=~/Downloads/
for filename in ~/Downloads/*; do
    base=${filename%.*}
    ext=${filename#"$base".}
    extDir=${dir}${ext}
    echo "$filename"
    echo "$base"
    echo "$ext"
    if [ -d "$extDir" ]; then
        echo "Moving $filename to $extDir"
        mv "${filename}" "${extDir}"
    else
        echo "$extDir doesn't exist, creating directory"
        mkdir "$extDir"
        echo "Moving $filename to $extDir"
        mv "$filename" "$extDir"
    fi
done
