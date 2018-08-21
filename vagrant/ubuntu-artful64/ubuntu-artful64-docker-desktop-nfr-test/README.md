# Configuration

This machine definition produces a base Ubuntu 17.10 Artful x64 installation with the following extras:

* Docker Community Edition 18.03.0
* Docker Compose 1.8.0
* Build Essentials (inclusive of Make etc.)
* Ubuntu Gnome Desktop
* Gnome Flashback
* Java
* jMeter
* OWASP ZAP

## Desktop environment choice

This box comes with a choice of desktop environments; Unity Gnome Desktop or Gnome Flashback. 
Should the Unity Gnome Desktop shows sign of lag, please switch to using the Gnome Flashback desktop manager (by selecting this session type on the login screen).

In order to launch OWASP ZAP, run the following commands:
```
cd /usr/share/owasp-zap/
./zap.sh
```
