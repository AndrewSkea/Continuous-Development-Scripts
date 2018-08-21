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

# Clean up any deb caches
apt-get clean