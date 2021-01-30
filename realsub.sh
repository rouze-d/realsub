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
echo -e "${STAND}                               by-$BOLD rouze-d$STAND"
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
    timeout 6 curl http://${sub2} -sI -X GET > .realsub.txt
    cat .realsub.txt | grep -E [A-Z] > /dev/null
    if [ "$?" != 1 ];then
        cat .realsub.txt | head -n1 | grep -E  '200'\|'301'\|'302' > /dev/null
        if [ "$?" != 1 ];then
            cat .realsub.txt | head -n1 | grep '200' > /dev/null
            if [ "$?" != 1 ];then
                echo -e "${STAND}http://${sub2} ${BOLD}${GREEN}UP"
            else
                lo=`cat .realsub.txt | grep -i 'Location'`
                echo ${STAND}http://${sub2} redirect to ${YELLOW}${BOLD}$lo
            fi
        else
            echo -e "${STAND}https://${sub2} ${BOLD}${YELLOW}$(cat .realsub.txt | head -1)" # && echo $(cat .realsub.txt | grep -i locat)
        fi
    else
        echo -e "${STAND}http://${sub2} ${BOLD}${RED}DOWN"
    fi

    rm -f .realsub.txt

    #echo ""
    timeout 6 curl https://${sub2} -sI -X GET > .realsub.txt
    cat .realsub.txt | grep -E [A-Z] > /dev/null
    if [ "$?" != 1 ];then
        cat .realsub.txt | head -n1 | grep -E  '200'\|'301'\|'302' > /dev/null
        if [ "$?" != 1 ];then
            cat .realsub.txt | head -n1 | grep '200' > /dev/null
            if [ "$?" != 1 ];then
                echo -e "${STAND}https://${sub2} ${BOLD}${GREEN}UP"
            else
                lo=`cat .realsub.txt | grep -i 'Location'`
                echo ${STAND}https://${sub2} redirect to ${YELLOW}${BOLD}$lo
            fi
        else
            echo -e "${STAND}https://${sub2} ${BOLD}${YELLOW}$(cat .realsub.txt | head -1)" # && echo $(cat .realsub.txt | grep -i locat)
        fi
    else
        echo -e "${STAND}https://${sub2} ${BOLD}${RED}DOWN"
    fi

    rm -f .realsub.txt

exit 0
fi


if [ $sub == "-w" ];then
    for x in `cat ${sub2}`
    do
    echo ""
    timeout 6 curl http://${x} -sI -X GET > .realsub.txt
    cat .realsub.txt | grep -E [A-Z] > /dev/null
    if [ "$?" != 1 ];then
        cat .realsub.txt | head -n1 | grep -E  '200'\|'301'\|'302' > /dev/null
        if [ "$?" != 1 ];then
            cat .realsub.txt | head -n1 | grep '200' > /dev/null
            if [ "$?" != 1 ];then
                echo -e "${STAND}http://${x} ${BOLD}${GREEN}UP"
            else
                lo=`cat .realsub.txt | grep -i 'Location'`
                echo ${STAND}http://${x} redirect to ${YELLOW}${BOLD}$lo
            fi
        else
            echo -e "${STAND}http://${x} ${BOLD}${YELLOW}$(cat .realsub.txt | head -1)" # && echo $(cat .realsub.txt | grep -i locat)
        fi
    else
        echo -e "${STAND}http://${x} ${BOLD}${RED}DOWN"
    fi

    rm -f .realsub.txt

    #echo ""
    timeout 6 curl https://${x} -sI -X GET > .realsub.txt
    cat .realsub.txt | grep -E [A-Z] > /dev/null
    if [ "$?" != 1 ];then
        cat .realsub.txt | head -n1 | grep -E  '200'\|'301'\|'302' > /dev/null
        if [ "$?" != 1 ];then
            cat .realsub.txt | head -n1 | grep '200' > /dev/null
            if [ "$?" != 1 ];then
                echo -e "${STAND}https://${x} ${BOLD}${GREEN}UP"
            else
                lo=`cat .realsub.txt | grep -i 'Location'`
                echo ${STAND}https://${x} redirect to ${YELLOW}${BOLD}$lo
            fi
        else
            echo -e "${STAND}https://${x} ${BOLD}${YELLOW}$(cat .realsub.txt | head -1)" # && echo $(cat .realsub.txt | grep -i locat)
        fi
    else
        echo -e "${STAND}https://${x} ${BOLD}${RED}DOWN"
    fi

    rm -f .realsub.txt
    done

exit 0
fi

echo -e " Unknown Options for $sub"
