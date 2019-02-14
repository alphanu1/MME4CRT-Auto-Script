#!/bin/bash

NC = "\033[0m"

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

xrandr --newmode "700x480_59.941002" 13.849698 700 742 801 867 480 490 496 533 interlace -hsync -vsync && xrandr --newmode "700x480_59.941002" 13.849698 700 742 801 867 480 490 496 533 interlace -hsync -vsync
xrandr --addmode $output 700x480_59.941002
xrandr --output $output --mode 700x480_59.941002

echo "$STR"
echo -e "\033[32mCreating .xprofile using output "$output "\033[0m"
echo "$STR"
sleep 1

exec 3<> ~/.xprofile
	echo "#!/bin/sh" >&3
	echo "xrandr --newmode \"700x480_59.941002\" 13.849698 700 742 801 867 480 490 496 533 interlace -hsync -vsync" >&3
	echo "xrandr --addmode "$output" 700x480_59.941002" >&3
	echo "xrandr --output "$output" --mode 700x480_59.941002" >&3
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
