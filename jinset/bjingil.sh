#!/bin/bash
export DISPLAY=:0
export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus
cd "`echo $HOME`"/jingil/
for D in `find . -type d`
do
    if [ "$D" != "." ];then
      cd $D
      ./jingil.sh
      cd "`echo $HOME`"/jingil
    fi
done
