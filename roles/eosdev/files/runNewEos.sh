#!/bin/bash

NORMAL=$(tput sgr0)
GREEN=$(tput setaf 2; tput bold)
RED=$(tput setaf 1)

function green() {
    echo -e "$GREEN$*$NORMAL"
}

function red() {
    echo -e "$RED$*$NORMAL"
}

# Main part
sudo service eos stop
cd /home/esindril/Programs/eos/build/
make -j $1

if [ $? -ne 0 ]; then
    red "Compilation failed!"
    exit 1
else
    green "Compilation successful!"
    sudo make install

    if [ $? -ne 0 ]; then
        red "Installation failed!"
        exit 1
    else
        green "Installation successful"
        sudo cp /etc/xrd.cf.mgm_bkp /etc/xrd.cf.mgm
        sudo service eos start
    fi
fi

green "All done!"
