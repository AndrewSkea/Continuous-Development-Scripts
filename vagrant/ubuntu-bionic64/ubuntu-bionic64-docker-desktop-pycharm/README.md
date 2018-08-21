# Configuration

This machine definition produces a base Ubuntu 18.04 Bionic x64 installation with the following extras:

* Docker Community Edition 18.03.0
* Docker Compose 1.8.0
* Build Essentials (inclusive of Make etc.)
* Selenium Gecko Driver
* Python pip (2 & 3)
* Python virtualenv
* Pycharm Community Edition
* Ubuntu Gnome Desktop
* Gnome Flashback

## Desktop environment choice

This box comes with a choice of desktop environments; Unity Gnome Desktop or Gnome Flashback. 
Should the Unity Gnome Desktop shows sign of lag, please switch to using the Gnome Flashback desktop manager (by selecting this session type on the login screen).

## Post provisioning steps

Once your VM has been provisioned, you should create a venv environment to isolate python runtimes. 
To do so, in a terminal prompt navigate to /home/vagrant/ and create a new venv by issuing the following command 
(changing example-venv to an appropriate value that best describes your project)
`python3 -m venv example-venv`

To activate your new virtual environment first change into your newly created environment directory (in the example above this would be named example-venv).
Once you have changed directory run the command `. bin/activate`. You should now see the name of your new virtual environment prefixing your shell prompt.

When first opening PyCharm link your newly created virtual environment by navigating to File -> Settings -> Poject Interpreter -> Add then choose 
the "existing environment" which should have an existing entry present for your newly created venv instance.