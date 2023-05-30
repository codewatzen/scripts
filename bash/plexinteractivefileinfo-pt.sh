#!/bin/bash
function movies() {
    videodirs="${plex}/movies"
    csv="${HOME}/moviefilesinfo.csv"
    echo "Size (GB);File Name;Resolution;Codec" >"${csv}"
    fdfind -t f -E "*.gz" -E "*.srt" -E "*.sub" . ${videodirs} \
        -x ffprobe -v quiet -print_format json -show_format -select_streams v:0 \
        -show_entries stream \
        -i | jq --raw-output '. | "=\(.format.size)/1073741824;\((.format.filename | sub(".+(?=\/).";"")));\(.streams[0].width)x\(.streams[0].height);\(.streams[0].codec_name)"' >>"${csv}"
}

selection() {
    PS3='Which Plex folder do you want to get information from: '
    options=("Anime Movies" "Kid Movies" "Movies" "Sports" "Quit")
    select opt in "${options[@]}"; do
        case $opt in
        "Anime Movies")
            echo "you chose $opt running animovies fuction now."
            break
            ;;
        "Kid Movies")
            echo "you chose $opt running kidmovies fuction now."
            break
            ;;
        "Movies")
            echo "you chose $opt running movies fuction now."
            break
            ;;
        "Sports")
            echo "you chose $opt running sports fuction now."
            break
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY" ;;
        esac
    done
}

selection
