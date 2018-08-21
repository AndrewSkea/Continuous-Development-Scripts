# Install selenium gecko driver
wget https://github.com/mozilla/geckodriver/releases/download/v0.20.1/geckodriver-v0.20.1-linux64.tar.gz
tar -xvzf geckodriver-v0.20.1-linux64.tar.gz
rm geckodriver-v0.20.1-linux64.tar.gz
chmod +x geckodriver
cp geckodriver /usr/local/bin/

# Install latest version of pip2 and pip3
apt-get -y install python-pip
pip2 install --upgrade pip

apt-get -y install python3-pip
pip3 install --upgrade pip

# Install python 3 virtual env
apt-get -y install python3-venv
pip install virtualenv

# Install pycharm using snap installer
snap install pycharm-community --classic