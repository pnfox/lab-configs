#!/bin/bash

POSITIONAL=()
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -g|--global)
    GLOBAL="1"
    shift # past argument
    shift # past value
    ;;
    -l|--local)
    LOCAL="1"
    shift # past argument
    shift # past value
    ;;
    *)    # unknown option
    POSITIONAL+=("$1") # save it in an array for later
    shift # past argument
    ;;
esac
done

if [ $GLOBAL ]
then
    echo "Copying config files globally";

    cp configs/Xresources /etc/X11/.
    xrdb /etc/X11/Xresources

    cp /etc/i3/config /etc/i3/config.bak
    cp configs/i3.conf /etc/i3/config

    cp /etc/xgb/tint2/tint2rc /etc/xgb/tint2/tintrc.bak
    cp configs/tint2.conf /etc/xgb/tint2/tint2rc

fi

if [ $LOCAL ]
then
    echo "Copying config files locally, to $HOME/.config";

    cp configs/Xresources $HOME/.
    xrdb $HOME/Xresources

    cp $HOME/.config/i3/config $HOME/.config/i3/config.bak
    cp configs/i3.conf $HOME/.config/i3/config

    cp configs/tint2.conf $HOME/.config/tint2/.

fi
