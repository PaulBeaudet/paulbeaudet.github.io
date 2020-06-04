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
<<COMMENT
    delimiter=.
    s=$post$delimiter
    dotsplit=();
    while [[ $s ]]; do
        dotsplit+=( "${s%%"$delimiter"*}" );
        s=${s#*"$delimiter"};
    done;
COMMENT
    spliter $post .
    dotsplitZero=${globAr[0]}
    spliter $dotsplitZero -
    hyphensplitThree=${globAr[3]}
    spliter $dotsplitZero /
    slashsplitOne=${globAr[1]}
<<COMMENT
    delimiter=-
    s=${dotsplit[0]}$delimiter
    hyphensplit=();
    while [[ $s ]]; do
        hyphensplit+=( "${s%%"$delimiter"*}" );
        s=${s#*"$delimiter"};
    done;
    delimiter=/
    s=${dotsplit[0]}$delimiter
    slashsplit=();
    while [[ $s ]]; do
        slashsplit+=( "${s%%"$delimiter"}" );
        s=${s#*"$delimiter"};
    done;
COMMENT
    postToMatch="$(tr [A-Z] [a-z] <<< "$hyphensplitThree")"
    echo $postToMatch
    matchFound=false
    for picDirs in assets/img/hiking/*; do
        pics="$(tr [A-Z] [a-z] <<< "$picDirs")"
        if [[ "$pics" == *"$postToMatch"* ]]; then
            echo "match-> $picDirs"
            matchFound=true
            # newFolder=$HOME/development/react/paul_deabute_com_blog/content/blog2/${slashsplit[1]}
            newFolder=$HOME/Downloads/blog2/$slashsplitOne
            # mkdir -p $newFolder
            # cp $post $newFolder/${slashsplit[1]}.md
            # cp $picDirs/* $newFolder/
            break
        fi
    done
    if [ $matchFound == false ]; then
        echo "No match found"
    fi
done
#!/bin/bash
#!/bin/bash
#!/bin/bash
