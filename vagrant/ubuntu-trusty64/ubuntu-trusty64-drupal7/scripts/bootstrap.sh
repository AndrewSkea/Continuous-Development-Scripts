# Set timezone to Europe/London
timedatectl set-timezone Europe/London

# Set UK keyboard layout
sed -i "s/.*XKBLAYOUT=.*/XKBLAYOUT=gb/g" /etc/default/keyboard

# Install build dependencies
apt-get -y update
apt-get -y install build-essential module-assistant

# Allow SSH password authentication
sed -i "s/.*PasswordAuthentication.*/PasswordAuthentication yes/g" /etc/ssh/sshd_config
systemctl restart ssh

# Set up sudo
echo 'vagrant ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/vagrant
chmod 0440 /etc/sudoers.d/vagrant
usermod -a -G sudo vagrant