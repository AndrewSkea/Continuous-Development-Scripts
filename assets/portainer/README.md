# Launching the portainer stack

To launch portainer, first create a data directory that will store your configuration, users settings by running the command ```mkdir -p /opt/docker/portainer/data```.

If you want to connect to your particular docker instance remotely from another Portainer instance (as an endpoint), you will need to expose the daemon over TCP as detailed at: https://docs.docker.com/install/linux/linux-postinstall/#configure-where-the-docker-daemon-listens-for-connections

To deploy the stack run the command ```docker stack deploy --compose-file docker-stack.yml portainer```. 

Once necessary assets (e.g. Docker images) have been downloaded, portainer should become available on port 9000.