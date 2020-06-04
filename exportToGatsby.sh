#!/bin/bash

globAr=();
spliter () {
    delimiter=$2
    s=$1$delimiter
    globAr=();
    while [[ $s ]]; do
        globAr+=( "${s%%"$delimiter"*}" );
        s=${s#*"$delimiter"};
    done;
}

for post in _posts/*; do
    spliter $post .
    dotsplitZero=${globAr[0]}
    spliter $dotsplitZero -
    hyphensplitThree=${globAr[3]}
    spliter $dotsplitZero /
    slashsplitOne=${globAr[1]}
    postToMatch="$(tr [A-Z] [a-z] <<< "$hyphensplitThree")"
    echo $postToMatch
    matchFound=false
    for picDirs in assets/img/hiking/*; do
        pics="$(tr [A-Z] [a-z] <<< "$picDirs")"
        if [[ "$pics" == *"$postToMatch"* ]]; then
            echo "match-> $picDirs"
            matchFound=true
            # newFolder=$HOME/development/react/paul_deabute_com_blog/content/blog2/$slashsplitOne}
            newFolder=$HOME/Downloads/blog2/$slashsplitOne
            mkdir -p $newFolder
            cp $post $newFolder/$slashsplitOne.md
            cp $picDirs/* $newFolder/
            break
        fi
    done
    if [ $matchFound == false ]; then
        echo "No match found"
    fi
done
