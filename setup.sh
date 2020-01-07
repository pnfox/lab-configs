#!/bin/bash

scriptDir=$PWD

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

    cp scripts/battery.sh /etc/.
    chmod +x /etc/battery.sh
    echo "alias battery='sh /etc/battery.sh'" >> /etc/bashrc

    cp scripts/planner.py /etc/.
    chmod +x /etc/planner.py
    echo "alias planner='python /etc/planner.py'" >> /etc/bashrc

    cp /etc/xdg/tint2/tint2rc /etc/xdg/tint2/tintrc.bak
    cp configs/tint2.conf /etc/xdg/tint2/tint2rc
    cp assets/launch.png /usr/share/tint2/.

    cp /usr/share/dunst/dunstrc /usr/share/dunst/dunstrc.bak
    cp configs/dunstrc /usr/share/dunst/dunstrc

    cp /etc/conky/conky.conf /etc/conky/conky.conf.bak
    cp configs/conkyrc /etc/conky/conky.conf

    cp configs/launchy.png /usr/share/icons/.

    cp assets/powerOff.png /usr/share/icons/.
    cp assets/reboot.png /usr/share/icons/.
    cp assets/suspend.png /usr/share/icons/.

    cp assets/default.png /usr/share/backgrounds/default.png

fi

if [ $LOCAL ]
then
    echo "Copying config files locally, to $HOME/.config";

    cp configs/Xresources $HOME/.
    xrdb $HOME/Xresources

    cp $HOME/.config/i3/config $HOME/.config/i3/config.bak
    cp configs/i3.conf $HOME/.config/i3/config

    cp configs/tint2.conf $HOME/.config/tint2/.
    cp assets/launch.png /usr/share/tint2/.

    mkdir $HOME/.config/dunst
    cp configs/dunstrc $HOME/.config/dunst/.

    mkdir $HOME/.config/jgmenu
    cp configs/jgmenurc $HOME/.config/jgmenu/.
    cp configs/menu.csv $HOME/.config/jgmenu/.

    mkdir $HOME/.config/conky
    cp configs/conkyrc $HOME/.config/conky/.

    cp assets/powerOff.png /usr/share/icons/.
    cp assets/reboot.png /usr/share/icons/.
    cp assets/suspend.png /usr/share/icons/.

    cp assets/default.png /usr/share/backgrounds/default.png

fi

if [ ! $GLOBAL ] && [ ! $LOCAL ]
then
    echo "No config files setup on machine";
    echo "Please use -l --local to setup in $HOME/.config";
    echo "Or use -g --global to setup configuration globally";
fi

if ! command -v jgmenu; then
    cd /tmp
    git clone https://github.com/johanmalm/jgmenu.git
    cd jgmenu
    if [ -f /etc/redhat-release ]; then
        echo "Installing fedora dependencies for jgmenu"
        sudo dnf install -y -q libX11-devel libXrandr-devel libxml2-devel pango-devel cairo-devel librsvg2 librsvg2-devel menu-cache menu-cache-devel glibc-headers glib2-devel make gcc gcc-c++
        echo "Building jgmenu";
        ./configure
        sudo make;
        sudo make install;
        echo "Configure jgmenu";
        mkdir -p /etc/xdg/jgmenu
        cd $scriptDir
        cp configs/jgmenurc /etc/xdg/jgmenu/jgmenurc
        cp configs/menu.csv /etc/xdg/jgmenu/menu.csv
    else
        echo "Not fedora based distro, will not install jgmenu"
    fi
    cd $scriptDir
fi

cd $scriptDir
echo "Installing Papirus Icon Theme"
wget -qO- https://git.io/papirus-icon-theme-install | sh

