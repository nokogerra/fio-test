#!/bing/bash
sudo apt update
sudo apt install -y git
sudo apt install -y python3-pip
sudo apt install tmux
sudo pip3 install ansible jmespath matplotlib iostat-tool
git init
git clone https://github.com/nokogerra/fio-test