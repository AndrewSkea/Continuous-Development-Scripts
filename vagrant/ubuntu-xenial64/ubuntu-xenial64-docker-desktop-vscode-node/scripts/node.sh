# Install selenium gecko driver
wget https://github.com/mozilla/geckodriver/releases/download/v0.20.1/geckodriver-v0.20.1-linux64.tar.gz
tar -xvzf geckodriver-v0.20.1-linux64.tar.gz
rm geckodriver-v0.20.1-linux64.tar.gz
chmod +x geckodriver
cp geckodriver /usr/local/bin/

# Install the python-software-properties
apt-get -y install curl python-software-properties

# Download the nodesource
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -

# Install node from the downloaded source
apt-get -y install nodejs