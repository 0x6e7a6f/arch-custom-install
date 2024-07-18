#!/bin/bash
echo 'Installing Paru'
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
