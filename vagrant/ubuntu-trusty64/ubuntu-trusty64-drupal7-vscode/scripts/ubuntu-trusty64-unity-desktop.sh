# Install vbox guest addons
apt-get -y -f install dkms virtualbox-guest-dkms virtualbox-guest-x11

# Install desktop experience
apt-get -y install ubuntu-desktop

# Grant X manager permissions to vagrant user
touch /home/vagrant/.Xauthority
chown vagrant:vagrant /home/vagrant/.Xauthority
chmod 777 /home/vagrant/.Xauthority
chmod a+wt /tmp

# Disable user list on login prompt
printf "[SeatDefaults]\nallow-guest=false\ngreeter-hide-users=true\ngreeter-show-manual-login=true\n" > /usr/share/lightdm/lightdm.conf.d/50-no-guest.conf