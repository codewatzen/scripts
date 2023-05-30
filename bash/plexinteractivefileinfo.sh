#!/bin/bash

movies() {
    moviesdirs="${plex}/Movies/"
    moviesinfocsv="${HOME}/moviesinfo.csv"
    echo "Size (GB);File Name;Resolution;Codec" >"${moviesinfocsv}"
    fdfind -t f -E "*.gz" -E "*.srt" -E "*.sub" . "${moviesdirs}" \
        -x ffprobe -v quiet -print_format json -show_format -select_streams v:0 \
        -show_entries stream \
        -i | jq --raw-output '. | "=\(.format.size)/1073741824;\((.format.filename | sub(".+(?=\/).";"")));\(.streams[0].width)x\(.streams[0].height);\(.streams[0].codec_name)"' >> "${moviesinfocsv}"
}

animovies() {
    animoviesdir="${plex}/Anime Movies/"
    animoviesinfocsv="${HOME}/animoviesinfo.csv"
    echo "Size (GB);File Name;Resolution;Codec" >"${animoviesinfocsv}"
    fdfind -t f -E "*.gz" -E "*.srt" -E "*.sub" . "${animoviesdir}" \
        -x ffprobe -v quiet -print_format json -show_format -select_streams v:0 \
        -show_entries stream \
        -i | jq --raw-output '. | "=\(.format.size)/1073741824;\((.format.filename | sub(".+(?=\/).";"")));\(.streams[0].width)x\(.streams[0].height);\(.streams[0].codec_name)"' >> "${animoviesinfocsv}"
}

sports() {
    sportsdirs="${plex}/Sports/"
    sportsinfocsv="${HOME}/sportsinfo.csv"
    echo "Size (GB);File Name;Resolution;Codec" >"${sportsinfocsv}"
    fdfind -t f -E "*.gz" -E "*.srt" -E "*.sub" . "${sportsdirs}" \
        -x ffprobe -v quiet -print_format json -show_format -select_streams v:0 \
        -show_entries stream \
        -i | jq --raw-output '. | "=\(.format.size)/1073741824;\((.format.filename | sub(".+(?=\/).";"")));\(.streams[0].width)x\(.streams[0].height);\(.streams[0].codec_name)"' >> "${sportsinfocsv}"
}

kidsmovies() {
    kidsmoviesdirs="${plex}/Kids Movies/"
    kidsmoviesinfocsv="${HOME}/kidsmoviesinfo.csv"
    echo "Size (GB);File Name;Resolution;Codec" >"${kidsmoviesinfocsv}"
    fdfind -t f -E "*.gz" -E "*.srt" -E "*.sub" . "${kidsmoviesdirs}" \
        -x ffprobe -v quiet -print_format json -show_format -select_streams v:0 \
        -show_entries stream \
        -i | jq --raw-output '. | "=\(.format.size)/1073741824;\((.format.filename | sub(".+(?=\/).";"")));\(.streams[0].width)x\(.streams[0].height);\(.streams[0].codec_name)"' >> "${kidsmoviesinfocsv}"
}

all() {
    echo "Working on the Anime Movies directory."
    animovies
    echo "Working on the Kids Movies directory."
    kidsmovies
    echo "Working on the Movies directory."
    movies
    echo "Working on the Sports directory."
    sports
}

selection() {
    PS3='Which Plex folder do you want to get information from: '
    options=("Anime Movies" "Kids Movies" "Movies" "Sports" "All" "Quit")
    select opt in "${options[@]}"; do
        case $opt in
        "Anime Movies")
            echo "you chose $opt running animovies fuction now."
            animovies
            echo "Objective complete. Goodbye!"
            break
            ;;
        "Kid Movies")
            echo "you chose $opt running kidsmovies fuction now."
            kidsmovies
            echo "Objective complete. Goodbye!"
            break
            ;;
        "Movies")
            echo "you chose $opt running movies fuction now."
            movies
            echo "Objective complete. Goodbye!"
            break
            ;;
        "Sports")
            echo "you chose $opt running sports fuction now."
            sports
            echo "Objective complete. Goodbye!"
            break
            ;;
        "All")
            echo "you chose $opt running all function now."
            all
            echo "Objective complete. Goodbye!"
            break
            ;;
        "Quit")
            echo "Goodbye!"
            break
            ;;
        *) echo "invalid option $REPLY" ;;
        esac
    done
}

selection