#!/bin/bash
#
# Displays battery charge
#

if [ -d /sys/class/power_supply/BAT0 ]; then
    BAT="BAT0"
elif [ -d /sys/class/power_supply/BAT1 ]; then
    BAT="BAT1"
fi

chargenow=$(cat /sys/class/power_supply/$BAT/charge_now)
chargefull=$(cat /sys/class/power_supply/$BAT/charge_full)
status=$(cat /sys/class/power_supply/$BAT/status)

if [ "$status" == "Charging" ]; then
    echo "Charging"
    if [ $chargenow -lt $(bc <<< "$chargefull * 21 / 100") ]; then
        echo $(bc <<< "scale=2;$chargenow / $chargefull * 100") "%";
	    notify-send -i /usr/share/icons/Papirus/24x24/panel/battery-000-charging.svg "Charging"
    fi
    if [ $chargenow -gt $(bc <<< "$chargefull * 21 / 100") ] && [ $chargenow -lt $(bc <<< "$chargefull * 60 / 100") ]; then
        echo $(bc <<< "scale=2;$chargenow / $chargefull * 100") "%";
        notify-send -i /usr/share/icons/Papirus/24x24/panel/battery-020-charging.svg "Charging"
    fi
    if [ $chargenow -gt $(bc <<< "$chargefull * 61 / 100") ]; then
        echo $(bc <<< "scale=2;$chargenow / $chargefull * 100") "%";
        notify-send -i /usr/share/icons/Papirus/24x24/panel/battery-060-charging.svg "Charging"
    fi
else
    if [ $chargenow -lt $(bc <<< "$chargefull * 21 / 100") ]; then
        echo $(bc <<< "scale=2;$chargenow / $chargefull * 100") "%";
    fi
    if [ $chargenow -gt $(bc <<< "$chargefull * 21 / 100") ] && [ $chargenow -lt $(bc <<< "$chargefull * 60 / 100") ]; then
        echo $(bc <<< "scale=2;$chargenow / $chargefull * 100") "%";
    fi
    if [ $chargenow -gt $(bc <<< "$chargefull * 61 / 100") ]; then
        echo /usr/share/icons/Papirus/16x16/panel/battery-060.svg " " $(bc <<< "scale=2;$chargenow / $chargefull * 100") "%";
    fi
fi



# If less than 21% battery then display warning
if [ $((chargenow)) -lt $(bc <<< "$chargefull * 21 / 100") ]; then
    echo "Low Battery!"
    notify-send -i /usr/share/icons/Papirus/24x24/panel/battery-000.svg "Low Battery!"
fi
#echo "Laptop Charge: " $(bc <<< "scale=2;$chargenow / $chargefull * 100") "%"
#echo "Battery status: $status"
