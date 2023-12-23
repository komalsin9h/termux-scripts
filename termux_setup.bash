#!/bin/bash


read -p "Do you want to setup storage? (yes/no): " setup_storage

read -p "Do you want to install x11-repo and tur-repo? (yes/no): " install_repos

read -p "Do you want to install Chromium? (yes/no): " install_chromium

read -p "Do you want to install Selenium with Chrome? (yes/no): " install_selenium_chrome

read -p "Do you want to install Selenium with Firefox? (yes/no): " install_selenium_firefox

read -p "Do you want to install XFCE4 and VNC? (yes/no): " install_xfce_vnc



yes | pkg update -y
yes | pkg upgrade -y
yes | pkg install x11-repo -y
yes | pkg install tur-repo -y
yes | pkg update -y
yes | pkg upgrade -y
touch ~/.bashrc



if [[ "$setup_storage" =~ ^[Yy][Ee][Ss]$ || "$setup_storage" =~ ^[Yy]$ ]]; then
    echo "Setting up storage..."
    termux-setup-storage
    echo "Storage setup complete."
fi

if [[ "$install_repos" =~ ^[Yy][Ee][Ss]$ || "$install_repos" =~ ^[Yy]$ ]]; then
    echo "Installing repositories..."
    yes | pkg install x11-repo -y
    yes | pkg install tur-repo -y
    echo "Repository installation complete."
fi


if [[ "$install_chromium" =~ ^[Yy][Ee][Ss]$ || "$install_chromium" =~ ^[Yy]$ ]]; then
    echo "Installing Chromium..."
    yes | pkg install chromium -y
    echo "Chromium installation complete."
fi

if [[ "$install_selenium_chrome" =~ ^[Yy][Ee][Ss]$ || "$install_selenium_chrome" =~ ^[Yy]$ ]]; then
    echo "Installing Selenium with Chrome..."
    yes | pkg install chromium -y
    yes | pkg install python
    yes | pkg install python-pip -y
    pip install selenium==4.9.1
    echo "Selenium with Chrome installation complete."
fi

if [[ "$install_selenium_firefox" =~ ^[Yy][Ee][Ss]$ || "$install_selenium_firefox" =~ ^[Yy]$ ]]; then
    echo "Installing Selenium with Firefox..."
    yes | pkg install x11-repo -y
    yes | pkg install firefox -y
    yes | pkg install geckodriver -y
    echo "Selenium with Firefox installation complete."
fi

if [[ "$install_xfce_vnc" =~ ^[Yy][Ee][Ss]$ || "$install_xfce_vnc" =~ ^[Yy]$ ]]; then
    echo "Installing XFCE4 and VNC..."
    yes | pkg install tigervnc -y
    yes | pkg install xfce4 -y
    vncserver
    vncserver -kill :1
    cd .vnc
    echo "xfce4-session &" >> xstartup
    echo "twm &" >> xstartup
    echo "geometry=720x1600" >> config
    cd
    echo 'for display in $(vncserver -list | grep "^:" | cut -d":" -f2); do vncserver -kill :$display; done' >> ~/.bashrc
    clear
    echo "vncserver" >> ~/.bashrc
    echo "XFCE4 and VNC installation complete."
fi

if [[ "$install_terminal_theme" =~ ^[Yy][Ee][Ss]$ || "$install_terminal_theme" =~ ^[Yy]$ ]]; then
    echo "Installing theme..."
    yes | pkg install git -y
    yes | pkg install ncurses-utils -y
    yes | pkg install figlet -y
    git clone https://github.com/remo7777/T-Header.git
    cd T-Header
    bash t-header.sh
    cd ..
    rm -rf T-Header
    echo "Terminal theme installation complete."
fi


yes | pkg update -y
yes | pkg upgrade -y
