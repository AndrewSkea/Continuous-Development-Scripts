# Install Apache2
apt-get -y install apache2

# Install MySQL
debconf-set-selections <<< 'mysql-server-5.6 mysql-server/root_password password Inf0rm3d'
debconf-set-selections <<< 'mysql-server-5.6 mysql-server/root_password_again password Inf0rm3d'
apt-get -y install mysql-server-5.6 mysql-client-5.6

# Install MySQL Workbench and dependencies
apt-get -y install libctemplate2 libgtkmm-2.4-1c2a libpcrecpp0 libtinyxml2.6.2 libzip2 python-paramiko
wget http://dev.mysql.com/get/Downloads/MySQLGUITools/mysql-workbench-community-6.2.5-1ubu1404-amd64.deb
sudo dpkg -i mysql-workbench-community-6.2.5-1ubu1404-amd64.deb
rm -f mysql-workbench-community-6.2.5-1ubu1404-amd64.deb

# Install PHP
apt-get -y install python-software-properties
add-apt-repository ppa:ondrej/php
apt-get update
apt-get install -y php5.6 libapache2-mod-php5.6 php5.6-mysql php5.6-mysqli php5.6-curl

# Restart Apache
/etc/init.d/apache2 restart

# Install JDK
apt-get -y purge openjdk*
add-apt-repository -y ppa:webupd8team/java
apt-get update
echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections
apt-get -y install oracle-java8-installer
apt-get -y install oracle-java8-set-default

# Install Docker
apt-get update
apt-get -y install \
    linux-image-extra-$(uname -r) \
    linux-image-extra-virtual
curl -sSL -qo- https://get.docker.com/ | sh
usermod -aG docker vagrant
apt-get -y --force-yes install docker-ce=18.03.0~ce-0~ubuntu