# Vagrant development machines

The following software requirements are necessary to run these virtual machines:

1. Powershell 3 (available as part of the [Windows Management Framework 3.0 package](https://www.microsoft.com/en-us/download/details.aspx?id=34595))
1. [Vagrant](https://www.vagrantup.com/downloads.html)
1. [Virtualbox 2.5.8+](https://www.virtualbox.org/wiki/Downloads)

Please ensure that ports 5432 and 8000 to 8050 on your local machine are not in use before provisioning this machine.

## Provisioning a development machine

To provision a development machine, simply copy the directory that describes your chosen environment (e.g. ubuntu-xenial64-docker-unity) to your host machine. 
Once the folder has been copied, open a powershell command prompt in the copied directory (on your host machine) and issue the command `vagrant up`.
Once Vagrant has provisioned the machine, you can connect to the machine by running the command `vagrant ssh`. 
Alternatively, password-based login has been enabled on these machines meaning you can access the virtual box using PuTTY
by creating an SSH connection to 127.0.0.1:2222 using the credentials vagrant:vagrant.
By default Vagrant will create a /vagrant directory on your guest VM, exposing any files located in the same directory to your virtual guest on said path.