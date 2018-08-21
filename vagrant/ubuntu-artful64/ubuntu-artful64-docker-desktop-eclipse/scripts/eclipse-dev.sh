# Install selenium gecko driver
wget https://github.com/mozilla/geckodriver/releases/download/v0.20.1/geckodriver-v0.20.1-linux64.tar.gz
tar -xvzf geckodriver-v0.20.1-linux64.tar.gz
rm geckodriver-v0.20.1-linux64.tar.gz
chmod +x geckodriver
cp geckodriver /usr/local/bin/

# Install maven
apt-get -y install maven=3.5.0-6

# Install eclipse
export HOME=/home/vagrant
add-apt-repository -y ppa:lyzardking/ubuntu-make
apt-get update
apt-get -y install ubuntu-make
umake ide eclipse-jee /home/vagrant/.local/share/umake/ide/eclipse-jee