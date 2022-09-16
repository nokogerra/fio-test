#!/bin/bash
#if there is no proxy in your env, comment the next 2 lines
sudo bash -c 'echo HTTP_PROXY=http://ip_addr:port >> /etc/environment
source /etc/environment
sudo apt update
sudo apt install -y git
#if there is no proxy in your env, comment the next line
git config --global http.proxy http://ip_addr:port
sudo apt install -y python3-pip
sudo apt install tmux
#if there is no proxy in your env, remove the proxy switch
sudo pip3 --proxy http://ip_addr:port install ansible jmespath matplotlib iostat-tool
git init
git clone https://github.com/nokogerra/fio-test