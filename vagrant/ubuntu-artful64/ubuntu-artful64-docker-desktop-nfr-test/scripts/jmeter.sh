# Install Jmeter
apt-get -y install jmeter=2.13-3

# Install the unzip
apt-get -y install unzip

# Install the plugin
cd /tmp
wget http://jmeter-plugins.org/downloads/file/JMeterPlugins-Standard-1.4.0.zip
wget http://jmeter-plugins.org/downloads/file/JMeterPlugins-Extras-1.4.0.zip
wget http://jmeter-plugins.org/downloads/file/JMeterPlugins-ExtrasLibs-1.4.0.zip

# Unzip files
unzip -o JMeterPlugins-Standard-1.4.0.zip -d /usr/share/jmeter/
unzip -o JMeterPlugins-Extras-1.4.0.zip -d /usr/share/jmeter/
unzip -o JMeterPlugins-ExtrasLibs-1.4.0.zip -d /usr/share/jmeter/