# Clean up any deb caches
apt-get clean
apt-get autoremove

# Clear crash logs
rm -f /var/crash/*