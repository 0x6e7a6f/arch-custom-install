#!/bin/bash

# NVIDIA Drivers
read -p "Do you want to install Nvidia driver ? [y/N] " response

if [ $response == 'Y' ] || [ $response == 'y' ];
then
    ./blocks/nvidia.sh
fi


# WRAPPER INSTALLATION
read -p $'Which wrapping do you want to install ? \n1. The default option. For one who want to keep Pacman living\n2. Paru (for Rust lovers <3)\n3. Yay (The most popular Yogurt)\n' response

if [ $response == '2' ] || [ $response == 'paru' ] || [ $response == 'Paru' ];
then
    echo 'Paru option selected. (I love you, my dear Rust Lover)'
    ./blocks/paru.sh
elif  [ $response == '3' ] || [ $response == 'yay' ] || [ $response == 'Yay' ];
then
    echo 'Yay option selected.'
    ./blocks/yay.sh
else
    echo 'Default option selected. Nothing done !'
fi
