#!/bin/bash

YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
RED=$(tput setaf 1)
BLUE=$(tput setaf 4)
STAND=$(tput sgr 0)
BOLD=$(tput bold)




echo -e "${RED}
   ┏━┓   ┏━╸   ┏━┓   ╻     ┏━┓   ╻ ╻   ┏┓
   ┣┳┛   ┣╸    ┣━┫   ┃     ┗━┓   ┃ ┃   ┣┻┓
   ╹┗╸   ┗━╸   ╹ ╹   ┗━╸   ┗━┛   ┗━┛   ┗━┛"
echo -e "                               by-$BOLD rouze-d$STAND"
echo -e "$BLUE Find subdomain is Real or just a Redirect$STAND"
echo -e " Hope you found something. Have a nice day."

echo ""





sub="$1"
sub2="$2"

if [ -z $sub ]; then
    echo "-s single target"
    echo "-w file lists target"
    echo ""
    echo "Missing subdomain / lists file"
    echo "$0 -s sub.target.com"
    echo "$0 -w sub-lists.txt"
    exit
fi

if [ -z $sub2 ]; then
    echo "-s single target"
    echo "-w file lists target"
    echo ""
    echo "Missing subdomain / lists file"
    echo "$0 -s sub.target.com"
    echo "$0 -w sub-lists.txt"
    exit
fi

if [ $sub == "-s" ];then

    echo ""
    timeout 6 curl http://${sub2} -sI -X GET > sub.txt
    cat sub.txt | grep -E [A-Z] > /dev/null
    if [ "$?" != 1 ];then
        cat sub.txt | grep 200 > /dev/null
        if [ "$?" != 1 ];then
            echo -e "${STAND}http://${sub2} ${BOLD}${GREEN}UP"
        else
            echo -e "${STAND}http://${sub2} ${BOLD}${YELLOW}$(cat sub.txt | head -1)" # && echo $(cat sub.txt | grep -i locat)
        fi
    else
        echo -e "${STAND}http://${sub2} ${BOLD}${RED}DOWN"
    fi

    rm -f sub.txt

    #echo ""
    timeout 6 curl https://${sub2} -sI -X GET > sub.txt
    cat sub.txt | grep -E [A-Z] > /dev/null
    if [ "$?" != 1 ];then
        cat sub.txt | grep 200 > /dev/null
        if [ "$?" != 1 ];then
            echo -e "${STAND}https://${sub2} ${BOLD}${GREEN}UP"
        else
            echo -e "${STAND}https://${sub2} ${BOLD}${YELLOW}$(cat sub.txt | head -1)" # && echo $(cat sub.txt | grep -i locat)
        fi
    else
        echo -e "${STAND}https://${sub2} ${BOLD}${RED}DOWN"
    fi

    rm -f sub.txt

exit 0
fi


if [ $sub == "-w" ];then
    for x in `cat ${sub2}`
    do
    echo ""
    timeout 6 curl http://${x} -sI -X GET > sub.txt
    cat sub.txt | grep -E [A-Z] > /dev/null
    if [ "$?" != 1 ];then
        cat sub.txt | grep 200 > /dev/null
        if [ "$?" != 1 ];then
            echo -e "${STAND}http://${x} ${BOLD}${GREEN}UP"
        else
            echo -e "${STAND}http://${x} ${BOLD}${YELLOW}$(cat sub.txt | head -1)" # && echo $(cat sub.txt | grep -i locat)
        fi
    else
        echo -e "${STAND}http://${x} ${BOLD}${RED}DOWN"
    fi

    rm -f sub.txt

    #echo ""
    timeout 6 curl https://${x} -sI -X GET > sub.txt
    cat sub.txt | grep -E [A-Z] > /dev/null
    if [ "$?" != 1 ];then
        cat sub.txt | grep 200 > /dev/null
        if [ "$?" != 1 ];then
            echo -e "${STAND}https://${x} ${BOLD}${GREEN}UP"
        else
            echo -e "${STAND}https://${x} ${BOLD}${YELLOW}$(cat sub.txt | head -1)" # && echo $(cat sub.txt | grep -i locat)
        fi
    else
        echo -e "${STAND}https://${x} ${BOLD}${RED}DOWN"
    fi

    rm -f sub.txt
    done

exit 0
fi

echo -e " Unknown Options for $sub"
