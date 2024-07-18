#!/bin/bash

read -p "Do you want to install Nvidia driver ? [y/N] " response

if [ $response == 'Y' ] || [ $response == 'y' ];
then
    echo ./nvidia.conf
fi
