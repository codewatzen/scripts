#!/bin/bash
selection() {
PS3='Which Plex folder do you want to get information from: '
options=("Anime Movies" "Kid Movies" "Movies" "Sports" "Quit")
select opt in "${options[@]}"
do
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
        *) echo "invalid option $REPLY";;
    esac
done
}

selection
