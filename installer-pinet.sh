#!/bin/bash
#V A add in chmod scratch_gpio.sh
#Version B � go back to installing deb gpio package directly
#Version C � install sb files into /home/pi/Documents/Scratch Projects
#Version D � create �/home/pi/Documents/Scratch Projects� if it doesn�t exist
#Version E � change permissions on �/home/pi/Documents/Scratch Projects�
#Version F 13Oct12 � rem out rpi.gpio as now included in Raspbian
#Version G 20Mar13 - Allow otheruser option on commandline (Tnever/meltwater)
#Version H 24Mar13 - correct newline issues
#Version 29Oct13 Add in Chown commands and extra Adafruit and servod files and alter gpio_scrath2.sh and bit of chmod +x make V3
#Version 21Nov13 Change for ScratchGPIO V4
#Version 26Dec13 Change for ScratchGPIO4plus
#Version 18Dec13 Change for ScratchGPIO5
#Version 4Aug14 - change for ScratchGPIO5

SGHVER=$(<SGHVER.txt)
f_exit(){
echo ""
echo "Usage:"
echo "i.e. sudo NameOfInstaller.sh otheruser"
echo "Optional: Add a non-default 'otheruser' username after the command (default is:pi)."
exit
}
echo "Debug Info"

#echo $SUDO_USER

echo "Running Installer"
if [ -z $1 ]
then
#HDIR="/home/pi"
#USERID="pi"
#GROUPID="pi"
RDIR="/opt"
RUSERID="root"
RGROUPID="root"
else
#HDIR=/home/$1
USERID=`id -n -u $1`
GROUPID=`id -n -g $1`
fi

#Confirm if install should continue with default PI user or inform about commandline option.
echo ""
echo "Install Details:"
#echo "Home Directory: "$HDIR
#echo "User: "$USERID
#echo "Group: "$USERID
echo ""
#if [ ! -d "$HDIR" ]; then
#    echo ""; echo "The home directory does not exist!";f_exit;
#fi
#echo "Is the above Home directory and User/Group correct (1/2)?"
#select yn in "Continue" "Cancel"; do
#    case $yn in
#        Continue ) break;;
#        Cancel ) f_exit;;
#    esac
#done

echo "Please wait a few seconds"
pkill -f servod
sleep 1

echo "Thank you"
rm -rf $RDIR/scratchgpio${SGHVER}

mkdir -p $RDIR/scratchgpio${SGHVER}
mkdir -p $RDIR/scratchgpio${SGHVER}/mcpi

#chown -R $RUSERID:$RGROUPID $HDIR/scratchgpio${SGHVER}

cp scratchgpio_handler7.py $RDIR/scratchgpio${SGHVER}
cp Adafruit_I2C.py $RDIR/scratchgpio${SGHVER}
cp sgh_servod $RDIR/scratchgpio${SGHVER}
cp killsgh.sh $RDIR/scratchgpio${SGHVER}
cp nunchuck.py $RDIR/scratchgpio${SGHVER}
cp meArm.py $RDIR/scratchgpio${SGHVER}
cp kinematics.py $RDIR/scratchgpio${SGHVER}
cp sgh_*.py $RDIR/scratchgpio${SGHVER}

cp ./mcpi/* $RDIR/scratchgpio${SGHVER}/mcpi

#chown -R $USERID:$GROUPID $RDIR/scratchgpio${SGHVER}
chmod +x sgh_servod
chmod +x killsgh.sh


#Instead of copying the scratchgpioX.sh file, we will generate it
#Create a new file for scratchgpioX.sh
echo "#!/bin/bash" > $RDIR/scratchgpio${SGHVER}/scratchgpio${SGHVER}.sh
echo "#Version 0.2 - add in & to allow simultaneous running of handler and Scratch" >> $RDIR/scratchgpio${SGHVER}/scratchgpio${SGHVER}.sh
echo "#Version 0.3 - change sp launches rsc.sb from \"/home/pi/Documents/Scratch Projects\"" >>$RDIR/scratchgpio${SGHVER}/scratchgpio${SGHVER}.sh
echo "#Version 0.4 - 20Mar13 meltwater - change to use provided name for home" >> $RDIR/scratchgpio${SGHVER}/scratchgpio${SGHVER}.sh
echo "#Version 1.0 - 29Oct13 sw - change to cd into simplesi_scratch_handler to run servods OK" >> $RDIR/scratchgpio${SGHVER}/scratchgpio${SGHVER}.sh
echo "sudo pkill -f scratchgpio_handler" >> $RDIR/scratchgpio${SGHVER}/scratchgpio${SGHVER}.sh
echo "cd $RDIR/scratchgpio"$SGHVER >> $RDIR/scratchgpio${SGHVER}/scratchgpio${SGHVER}.sh
echo "sudo python scratchgpio_handler7.py 127.0.0.1 standard &" >> $RDIR/scratchgpio${SGHVER}/scratchgpio${SGHVER}.sh
echo "scratch --document \"xxx/Documents/Scratch Projects/rsc.sb\" &" >> $RDIR/scratchgpio${SGHVER}/scratchgpio${SGHVER}.sh

chmod +x $RDIR/scratchgpio${SGHVER}/scratchgpio${SGHVER}.sh
#chown -R $USERID:$GROUPID $RDIR/scratchgpio${SGHVER}/scratchgpio${SGHVER}.sh

#Create new desktop icon
#echo "[Desktop Entry]" > $HDIR/Desktop/scratchgpio${SGHVER}.desktop
#echo "Encoding=UTF-8" >> $HDIR/Desktop/scratchgpio${SGHVER}.desktop
#echo "Version=1.0" >> $HDIR/Desktop/scratchgpio${SGHVER}.desktop
#echo "Type=Application" >> $HDIR/Desktop/scratchgpio${SGHVER}.desktop
#echo "Exec="$RDIR"/scratchgpio"$SGHVER"/scratchgpio"$SGHVER".sh" >> $HDIR/Desktop/scratchgpio${SGHVER}.desktop
#echo "Icon=scratch" >> $HDIR/Desktop/scratchgpio${SGHVER}.desktop
#echo "Terminal=false" >> $HDIR/Desktop/scratchgpio${SGHVER}.desktop
#echo "Name=ScratchGPIO "$SGHVER >> $HDIR/Desktop/scratchgpio${SGHVER}.desktop
#echo "Comment= Programming system and content development tool" >> $HDIR/Desktop/scratchgpio${SGHVER}.desktop
#echo "Categories=Application;Education;Development;" >> $HDIR/Desktop/scratchgpio${SGHVER}.desktop
#echo "MimeType=application/x-scratch-project" >> $HDIR/Desktop/scratchgpio${SGHVER}.desktop

#chown -R $USERID:$GROUPID $HDIR/Desktop/scratchgpio${SGHVER}.desktop


#Instead of copying the scratchgpioXplus.sh file, we will generate it
#Create a new file for scratchgpioXplus.sh
echo "#!/bin/bash" > $RDIR/scratchgpio${SGHVER}/scratchgpio${SGHVER}plus.sh
echo "#Version 0.2 - add in & to allow simulatenous running of handler and Scratch" >> $RDIR/scratchgpio${SGHVER}/scratchgpio${SGHVER}plus.sh
echo "#Version 0.3 - change sp launches rsc.sb from \"/home/pi/Documents/Scratch Projects\"" >> $RDIR/scratchgpio${SGHVER}/scratchgpio${SGHVER}plus.sh
echo "#Version 0.4 - 20Mar13 meltwater - change to use provided name for home" >> $RDIR/scratchgpio${SGHVER}/scratchgpio${SGHVER}plus.sh
echo "#Version 1.0 - 29Oct13 sw - change to cd into simplesi_scratch_handler to run servods OK" >> $RDIR/scratchgpio${SGHVER}/scratchgpio${SGHVER}plus.sh
echo "sudo pkill -f scratchgpio_handler" >> $RDIR/scratchgpio${SGHVER}/scratchgpio${SGHVER}plus.sh
echo "cd $RDIR/scratchgpio"$SGHVER >> $RDIR/scratchgpio${SGHVER}/scratchgpio${SGHVER}plus.sh
echo "sudo python scratchgpio_handler7.py &" >> $RDIR/scratchgpio${SGHVER}/scratchgpio${SGHVER}plus.sh
echo "scratch --document \"xxx/Documents/Scratch Projects/rsc.sb\" &" >> $RDIR/scratchgpio${SGHVER}/scratchgpio${SGHVER}plus.sh

chmod +x $RDIR/scratchgpio${SGHVER}/scratchgpio${SGHVER}plus.sh
#chown -R $USERID:$GROUPID $HDIR/scratchgpio${SGHVER}/scratchgpio${SGHVER}plus.sh

#Create new desktop icon for plus version
#echo "[Desktop Entry]" > $HDIR/Desktop/scratchgpio${SGHVER}plus.desktop
#echo "Encoding=UTF-8" >>  $HDIR/Desktop/scratchgpio${SGHVER}plus.desktop
#echo "Version=1.0" >>  $HDIR/Desktop/scratchgpio${SGHVER}plus.desktop
#echo "Type=Application" >>  $HDIR/Desktop/scratchgpio${SGHVER}plus.desktop
#echo "Exec="$RDIR"/scratchgpio"$SGHVER"/scratchgpio"$SGHVER"plus.sh" >>  $HDIR/Desktop/scratchgpio${SGHVER}plus.desktop
#echo "Icon=scratch" >>  $HDIR/Desktop/scratchgpio${SGHVER}plus.desktop
#echo "Terminal=false" >>  $HDIR/Desktop/scratchgpio${SGHVER}plus.desktop
#echo "Name=ScratchGPIO "$SGHVER"plus" >>  $HDIR/Desktop/scratchgpio${SGHVER}plus.desktop
#echo "Comment= Programming system and content development tool" >>  $HDIR/Desktop/scratchgpio${SGHVER}plus.desktop
#echo "Categories=Application;Education;Development;" >>  $HDIR/Desktop/scratchgpio${SGHVER}plus.desktop
#echo "MimeType=application/x-scratch-project" >>  $HDIR/Desktop/scratchgpio${SGHVER}plus.desktop

#chown -R $USERID:$GROUPID  $HDIR/Desktop/scratchgpio${SGHVER}plus.desktop

#cp blink11.py $HDIR




#mkdir -p $HDIR/Documents
#chown -R $USERID:$GROUPID $HDIR/Documents

#mkdir -p $HDIR/Documents/Scratch\ Projects
#chown -R $USERID:$GROUPID $HDIR/Documents/Scratch\ Projects

#cp rsc.sb $HDIR/Documents/Scratch\ Projects
#cp GPIOexample.sb $HDIR/Documents/Scratch\ Projects
#cp blink11.sb $HDIR/Documents/Scratch\ Projects
#chown -R $USERID:$GROUPID $HDIR/Documents/Scratch\ Projects
echo ""
echo "Finished."
