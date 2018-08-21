# Install vbox guest addons
apt-get -y -f install dkms virtualbox-guest-dkms virtualbox-guest-x11

# Install network manager in advance of Ubuntu desktop
apt-get -y install network-manager
systemctl enable NetworkManager
systemctl start NetworkManager

# Install gdm3 window manager
apt-get -y install gdm3
systemctl start gdm3

# Install ubuntu desktop experience
apt-get -y -f install ubuntu-gnome-desktop

# Add gnome session flashback as an option for lesser powered hosts
apt-get -y -f install gnome-session-flashback

# Add chromium
apt-get -y install chromium-browser