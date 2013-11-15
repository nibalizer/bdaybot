#!/usr/bin/env bash

password=`cat .password`
started=""
times=1
bar="'$BAR', patches welcome to support user voting"
cs333="the cs333 afterparty is at schmiza at 21:30 today"
timeofparty="the party will be starting at 4pm saturday nov 16. we will play games, drink and be merry. also further pressure askore to waffle+chicken"
monkey="The monkey is dancing.The monkey has danced $times times"
newbirthday="The koreans have reserved the viking game room in smith basement. Meet instead at the CS Lounge"
birthday="blkperl is turning 24 today! Lets meet on saturday for shenanigans at his house starting around 4."
address="blkperls is at 101 NE Cook & Rodney"
afterparty="If there is a motivated contingent(and there should be), an afterparty group may conglomerate and leave the lounge for greener pastures, in this event many of us have IRC on our phones and nibz' phone (619)-980-7820"
whatkindofbirthday="blkperl and nibalizer would like everyone to hang out and chill on saturday at his house starting about 4pm. There will be rock band, starcraft, and whatever board games the tamgc/lycopene contingent plan for.  Krinkle has approved this. After a few hours of gaming we'll devolve into drinking and merryment. We should all pressure askore to make her waffles and chicken thing."
amiinvited="You are invited, nibalizer loves all his friends and believes strongly in \"The more we get together, the happier we'll be, cus your friends are my friends, and my friends are your friends so lets all get together on sunday and get revel in awesomeness!\""
helpme="The following commands do things: /birthday, /whatkindofbirthday, /afterparty, /amiinvited, /help, /newbirthday, /cs333, /address, /time, /bar, /child"
botfile=botttttt
rm $botfile
mkfifo $botfile
tail -f $botfile | openssl s_client -connect irc.cat.pdx.edu:6697 | while true ; do
    if [ -z $started ] ; then
        echo "USER birthdaybot 9 nibzbot :My Bday is sunday1/13 in smith basement" > $botfile
        echo "NICK birthdaybot" > $botfile
        echo "JOIN #robots $password" > $botfile
        echo "JOIN #zombies $password" > $botfile
        echo "JOIN #gnarwals $password" > $botfile
        echo "JOIN #ataris $password" > $botfile
        echo "JOIN #meow $password" > $botfile
        echo "JOIN #cschat" > $botfile
        echo "JOIN #konapartment " > $botfile
        echo "JOIN #Games&Movies" > $botfile
        started="yes"
    fi
    read irc
    case `echo $irc | cut -d " " -f 1` in
         "PING") echo "PONG `hostname`" > $botfile
            ;;
    esac

    chan=`echo $irc | cut -d ' ' -f 3`
    barf=`echo $irc | cut -d ' ' -f 1-3`
    cmd=`echo ${irc##$barf :}|cut -d ' ' -f 1|tr -d "\r\n"`
    args=`echo ${irc##$barf :$cmd}|tr -d "\r\n"`
    nick="${irc%%!*}";nick="${nick#:}"
    if [ "`echo $cmd | cut -c1`" == "/" ] ; then
    echo "Got command $cmd from channel $chan with arguments $args"
    fi
    #echo "STARCRAFT in CSWINDOWS LAB" >> $botfile

case $cmd in
        #"!add") line="$args $line" ;;
        #"!list") echo "PRIVMSG $chan :$line" >> $botfile ;;
        "/birthday") echo "PRIVMSG $chan :$birthday" >> $botfile ;;
        "/address") echo "PRIVMSG $chan :$address" >> $botfile ;;
        "/time") echo "PRIVMSG $chan :$timeofparty" >> $botfile ;;
        "/whatkindofbirthday") echo "PRIVMSG $chan :$whatkindofbirthday" >> $botfile ;;
        "/afterparty") echo "PRIVMSG $chan :$afterparty" >> $botfile ;;
        "/cs333") echo "PRIVMSG $chan :$cs333" >> $botfile ;;
        "/amiinvited") echo "PRIVMSG $chan :Yes, $nick $amiinvited" >> $botfile ;;
        "/help") echo "PRIVMSG $chan :$helpme" >> $botfile ;;
        "/invited") echo "WHO $args" >> $botfile;;
        "/newbirthday") echo "PRIVMSG $chan :$newbirthday" >> $botfile;;
        "/bar") echo "PRIVMSG $chan :$bar" >> $botfile;;
        "/export") bar="$args" >> $botfile;;
        "/child") 
         echo "PRIVMSG $chan : _   _    _   _   _ ____  ____    _    ______   __" >> $botfile
         echo "PRIVMSG $chan :| | | |  / \\ | | | / ___|| __ )  / \\  | __ ) \\ / /" >> $botfile
         echo "PRIVMSG $chan :| |_| | / _ \\| | | \\___ \\|  _ \\ / _ \\ |  _ \\\\ V / " >> $botfile
         echo "PRIVMSG $chan :|  _  |/ ___ \\ |_| |___) | |_) / ___ \| |_) || |  " >> $botfile
         echo "PRIVMSG $chan :|_| |_/_/   \\_\\___/|____/|____/_/   \\_\\____/ |_|  " >> $botfile
         ;;
    esac
    echo $irc
done
