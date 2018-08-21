# Set timezone to Europe/London
timedatectl set-timezone Europe/London

# Set UK keyboard layout
sed -i "s/.*XKBLAYOUT=.*/XKBLAYOUT=gb/g" /etc/default/keyboard

# Install build dependencies
apt-get -y install build-essential

# Allow SSH password authentication
sed -i "s/.*PasswordAuthentication.*/PasswordAuthentication yes/g" /etc/ssh/sshd_config
systemctl restart ssh

# An install script is used here (rather than the vagrant provisioner) so that a named version
# of the Docker CE engine gets installed (rather than just pulling the latest version available) for consistency across environments
apt-get -y install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
apt-key fingerprint 0EBFCD88
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get -y update
apt-cache policy docker-ce
apt-get -y install docker-ce=18.03.0~ce-0~ubuntu
usermod -aG docker vagrant

# Again, an install script is used here to ensure consistency across environments (rather than just pulling latest)
test -e /usr/local/bin/docker-compose || curl -sSL https://github.com/docker/compose/releases/download/1.21.0/docker-compose-`uname -s`-`uname -m` | tee /usr/local/bin/docker-compose > /dev/null
chmod +x /usr/local/bin/docker-compose
test -e /etc/bash_completion.d/docker-compose || curl -sSL https://raw.githubusercontent.com/docker/compose/$(docker-compose --version | awk 'NR==1{print $NF}')/contrib/completion/bash/docker-compose | tee /etc/bash_completion.d/docker-compose > /dev/null

# Set up sudo
echo 'vagrant ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/vagrant
chmod 0440 /etc/sudoers.d/vagrant
usermod -a -G sudo vagrant