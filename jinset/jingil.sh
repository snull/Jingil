#!/bin/bash
export DISPLAY=:0
export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus
rssa=(`cat ./conf.txt`)
curl "$rssa" > ./rss.txt
a=(`grep  "<pubDate>" ./rss.txt`)
# z1 = year z2 = month z3 = day
z1=(`echo ${a[@]:3:1}`)
z1=$(($z1 * 10000000000))
z2=(`echo ${a[@]:2:1}`)
case $z2 in
    "Jan")
        z2="1" ;;
    "Feb")
        z2="2" ;;
    "Mar")
        z2="3" ;;
    "Apr")
        z2="4" ;;
    "May")
        z2="5" ;;
    "Jun")
        z2="6" ;;
    "Jul")
        z2="7" ;;
    "Aug")
        z2="8" ;;
    "Sep")
        z2="9" ;;
    "Oct")
        z2="10" ;;
    "Nov")
        z2="11" ;;
    "Dec")
        z2="12" ;;
esac
z2=$(($z2 * 100000000))
z3=(`echo ${a[@]:1:1}`)
z3=$(($z3 * 1000000))
b=(`echo ${a[@]:4:1}`)
# x1 = hour x2 = minute x3 = second
x1=(`echo ${b:0:2}`)
x1=$(($x1 * 10000))
x2=(`echo ${b:3:2}`)
x2=$(($x2 * 100))
x3=(`echo ${b:6:2}`)
if [ ${x3:0}==0 ];then
  x3=(`echo ${x3:1}`)
fi
dd=$(($z1 + $z2 + $z3 + $x1 + $x2 + $x3))
last_date=(`cat ./last_date.txt`)
if [[ "$last_date" -lt "$dd" ]];then
  echo $dd > ./last_date.txt
  site_name_notify=(`grep "<title>" ./rss.txt| head -2 | tail -1 | sed 's/<title>//' | sed 's/<\/title>//'`)
  site_link_notify=(`grep "<link>" ./rss.txt| head -2 | tail -1 | sed 's/<link>//' | sed 's/<\/link>//'`)
  notify-send "Jingil" "new post , (`echo ${site_name_notify[@]}`) on (`basename "$PWD"`)" -i "`echo $HOME`"/jingil/jingil.png
fi
