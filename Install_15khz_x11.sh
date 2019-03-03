#!/bin/bash

intel_res="xrandr --newmode \"1400x480_intel\" 28.625.426 1489 1563 1792 1255 480 490 496 533 interlace -hsync -vsync"
intel_mode="\"1400x480_intel\""
nvidia_res="xrandr --newmode \"1280x480_nvideo\" 26.181840 1280 1362 1429 1639 480 490 496 533 interlace -hsync -vsync"
nvidia_mode="\"1280x480_intel\""
ati_res="xrandr --newmode \"700x480_ait\" 13.849698 700 742 801 867 480 490 496 533 interlace -hsync -vsync"
ati_mode="\"700x480_ate\""
res_selection=""
choosen_res=""

check_res()
{

if [ -z "$res_selection" ]; then
    echo -e "\033[32mYou have not entered anything. Please try again.\033[0m"
	echo "$STR"
	read res_selection
	check_res
else
	if [ $res_selection == "1" ]; then 
		choosen_res="$ati_res"
		mode="$ati_mode"
	elif [ $res_selection == "2" ]; then
		choosen_res="$intel_res"
		mode="$intel_mode"
	elif [ $res_selection == "3" ]; then
		choosen_res="$nvidia_res"
		mode="$nvidia_mode"
	else
		echo -e "\033[32mYou have made an incorrect selction. Please try again.\033[0m"
		echo "$STR"
		read res_selection
		check_res
	fi
	echo "$STR"
fi
}

echo -e "\033[32mPlease select your video card make. $STR1. ATI $STR2. Intel $STR3. Nvidia $STR\033[0m"
echo -e "\033[32mChoose between 1, 2 or 3 followed by [ENTER]\033[0m"
echo "$STR"

read res_selection
echo "$STR"

check_res

echo -e "\033[32m$choosen_res $mode\033[0m"
echo "$STR"

NC="\033[0m"

echo "$STR"
echo -e "\033[32mConnected display outputs\033[0m"
echo "$STR"
xrandr | grep " connected" |  awk '{print$1}'

echo "$STR"
echo -e "\033[32mPlease type the connected output you wish to use for 15khz followed by [ENTER]\033[0m"
echo "$STR"
read output
echo


echo "$STR"
echo -e "\033[32mInstalling 15Khz desktop resolution for "$output "\033[0m"
echo "$STR"
sleep 1

$choosen_res
xrandr --addmode $output $mode
xrandr --output $output --mode $mode

echo "$STR"
echo -e "\033[32mCreating .xprofile using output "$output "\033[0m"
echo "$STR"
sleep 1

exec 3<> ~/.xprofile
	echo "#!/bin/sh" >&3
	echo $choosen_res >&3
	echo "xrandr --addmode "$output" "$mode >&3
	echo "xrandr --output "$output" --mode "$mode >&3
exec 3>&-

sleep 1

echo "$STR"
echo -e "\033[32mSetting file permissions for .xprofile\033[0m"
echo "$STR"
sleep 1

sudo chmod 777 ~/.xprofile

echo "$STR"
echo -e "\033[32mDone\033[0m"
echo "$STR"
sleep 1

