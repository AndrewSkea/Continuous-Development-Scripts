# Install selenium gecko driver
wget https://github.com/mozilla/geckodriver/releases/download/v0.20.1/geckodriver-v0.20.1-linux64.tar.gz
tar -xvzf geckodriver-v0.20.1-linux64.tar.gz
rm geckodriver-v0.20.1-linux64.tar.gz
chmod +x geckodriver
cp geckodriver /usr/local/bin/

# Install nodejs
apt-get -y install nodejs=6.11.4~dfsg-1ubuntu1

# Install NPM
apt-get -y install npm=3.5.2-0ubuntu4