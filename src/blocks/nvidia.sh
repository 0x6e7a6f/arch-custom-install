#!/bin/bash

paru -S nvidia nvidia-utils

# Path to the mkinitcpio.conf file
path="/etc/mkinitcpio.conf"

# Array of new modules to add
new_modules=('nvidia' 'nvidia_uvm' 'nvidia_modeset' 'nvidia_drm')

# Check if the mkinitcpio.conf file exists
if [ -f "$path" ]; then
    # Get the existing modules present
    modules=($(grep -oP '^[^#]*MODULES=\(\K[^)]+' $path))

    # Add module from new_modules if it isn't already present in the modules list
    for module in "${new_modules[@]}"; do
        existing=0
        for i in "${modules[@]}"; do
            if [ "$i" == "$module" ]; then
                existing=1
            fi
        done
        if [ $existing -eq 0 ]; then
            modules+=("$module")
        fi
    done

    # Sort the modules list
    modules=($(echo "${modules[@]}" | tr ' ' '\n' | sort))

    echo ${modules[@]}
    # Add the new modules to the file
    sudo sed -i "s/^MODULES=(\(.*\))/MODULES=(${modules[*]})/" "$path"

    echo "Modules have been added successfully to $path and new initramfs have been generated."
else
    echo "$path does not exist."
fi

# Creating a .conf file to add Nvidia-DRM options int  modprobe.d directory.
echo 'Adding the following DRM Settings : nvidia_drm modeset=1 fbdev=1'
echo 'options nvidia_drm modeset=1 fbdev=1' | sudo tee /etc/modprobe.d/nvidia_drm.conf > /dev/null

# Execute mkinitcpio command to generate the new initramfs
sudo mkinitcpio -p linux
