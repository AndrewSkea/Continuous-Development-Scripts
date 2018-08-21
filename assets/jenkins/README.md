## Launching the jenkins stack

To launch portainer, first create a data directory that will store your configuration, users settings by running the command ```mkdir -p /opt/docker/jenkins/jenkins_home```.

To deploy the stack run the command ```docker stack deploy --compose-file docker-stack.yml jenkins```