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
    matchedPicDir=''
    for picDirs in assets/img/hiking/*; do
        pics="$(tr [A-Z] [a-z] <<< "$picDirs")"
        if [[ "$pics" == *"$postToMatch"* ]]; then
            echo "match-> $picDirs"
            matchFound=true
            matchedPicDir=$picDirs
            # newFolder=$HOME/development/react/paul_deabute_com_blog/content/blog2/$slashsplitOne}
            newFolder=$HOME/Downloads/blog2/$slashsplitOne
            # mkdir -p $newFolder
            # cp $post $newFolder/$slashsplitOne.md
            # cp $picDirs/* $newFolder/
            break
        fi
    done
    if [ $matchFound == false ]; then
        # find linked pictures manually and copy them a folder made for this md post
        echo "No match found"
    else
        # Reword every image link in markdown to point internally (./imagename)
        while read line; do
            # Find line with ![]
            if [[ "![" == "$line"* ]]; then
                echo $line
            fi
        done < $post
    fi
<<COMMENT
    mkdir -p reblog
    cp $post reblog/$slashsplitOne.md
    grep -Fn '![' $copiedPost | sed "s:(.*):(./$slashsplitOne/:g"
COMMENT
done
