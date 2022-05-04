#!/bin/bash

# Created by: Mr Coxall
# Created on: May 2022
# This is a setup script for an AWS Academy EC2 Debian instance for ICS3U

# you will need to change permissions on the file before you can run it
# chmod +x ./setup.sh
#
# then run as:
# ./setup.sh

# get user name and email address to setup Git
echo The following is used to setup your GitHub connection
read -p "Enter your name (Ex: Mr Coxall): " userName
read -p "Enter your email address (Ex: mr.coxall@mths.ca): " useEmail
read -p "Enter your GitHub username (Ex: mr-coxall): " githubUser
read -s -p "Enter your GitHub password for user $githubUser: " githubPass


# update and upgrade system
echo Update and upgrade system
sudo apt-get update -y
sudo apt-get dist-upgrade -y
# so you can add in other apt repos
sudo apt-get install software-properties-common

# load git
sudo apt install -y git
$ git config --global user.name "$varName"
$ git config --global user.email useEmail

# provision GitHub
# -> from: https://gist.github.com/juanique/4092969
ssh-keygen -t ed25519 -C "$useEmail"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
pub=`cat ~/.ssh/id_ed25519.pub`
echo "Using username $githubUser"
curl -u "$githubUser:$githubPass" -X POST -d "{\"title\":\"`hostname`\",\"key\":\"$pub\"}" https://api.github.com/user/keys

# load NeoFetch
sudo apt install neofetch -y

# load pip3
echo Load programs
sudo apt-get install python3-pip -y

# python3 already installed
# install python linter
pip3 install black -y

# load C++
sudo apt install build-essential -y
# install C++ linter
pip3 install cpplint


# then remove the dot_files directory 
# sudo rm -R ~/AWS-Ubuntu-Setup-Script

# reboot
echo ---
echo -- Rebooting Instance --
echo ---
sudo reboot now


# after reboot, need to run the following by hand

# provision GitHub
# then copy public key over to GitHub SSH keys
# cat ~/.ssh/id_ed25519.pub
# to test it out
# ssh -T git@github.com

# configure GitHub CLI
# gh auth login
# web method most likely the easiest
# use existing GitHub SSH keys