# Install OWASP ZAP
sh -c "echo 'deb http://download.opensuse.org/repositories/home:/cabelo/xUbuntu_17.04/ /' > /etc/apt/sources.list.d/home:cabelo.list"
cd /tmp
wget -nv https://download.opensuse.org/repositories/home:cabelo/xUbuntu_17.04/Release.key -O Release.key
apt-key add - < Release.key
apt-get -y update
apt-get -y install owasp-zap