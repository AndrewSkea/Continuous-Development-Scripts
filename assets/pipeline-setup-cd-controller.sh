#!/bin/sh
#
# Shell script for automatically provisioning a CI/CD controller
# Any updates to this script should be made in keeping with the Google Shell Style Guide (https://google.github.io/styleguide/shell.xml)
#
# Author: James Cruddas

#######################################
# Prints usage help guidance to console
# Arguments:
#   None
# Returns:
#   None
#######################################
usage() {
 	 echo ""
	 echo "Usage: Unless additional flags are supplied when running this script, it will be assumed that no additional features (such as SCM or the ELK stack) are required. To bundle additional features, please use the flags below:"
	 echo ""
	 echo "--add-gitlab			provisions Gitlab container and adds NGINX config"
	 echo "--add-monitoring		provisions ELK stack containers and adds NGINX config"
	 echo "--add-docker-auto-maintain	adds docker system prune to weekly chron schedule"
 	 echo ""
  1>&2; exit 1;
}

##################################################
# Sets up the base features of a CI/CD controller
# Arguments:
#   None
# Returns:
#   None
###################################################
default() {

	#
	# Script integrity check																   
	#

	#If apt-get locks, prevent script from executing
	if apt-get update ; then
		echo "apt-get lock clear - setup script continuing"
	else
		echo "apt-get lock found - exiting setup script"
		exit
	fi

	#
	# Firewall configuration
	#

	#Permit traffic over port 22 to keep ssh enabled
	ufw allow 22

	#Permit traffic on port 80 for NGINX instance
	ufw allow 80

	#Allow swarm manager port
	ufw allow 2377
		
	#Add swarm ports for container discovery and ingress network
	ufw allow 7946
	ufw allow 4789
	
	#Jenkins slave communications port
	ufw allow 5000

	#Permit traffic for docker container HTTP access
	ufw allow 8000:9000/tcp
	
	#Enable firewall
	echo y | ufw enable

	#
	# Docker and Portainer setup   
	#

	#Install Docker
	curl -sSL https://get.docker.com/ | sh

	#Output docker version
	docker --version
	
	#Install docker compose
	COMPOSE_VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep 'tag_name' | cut -d\" -f4)
	sh -c "curl -L https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose"
	chmod +x /usr/local/bin/docker-compose
	sh -c "curl -L https://raw.githubusercontent.com/docker/compose/${COMPOSE_VERSION}/contrib/completion/bash/docker-compose > /etc/bash_completion.d/docker-compose"

	# Output compose version
	docker-compose -v
	
	#Permit forwarding to support Docker
	sed -i 's/DEFAULT_FORWARD_POLICY="DROP"/DEFAULT_FORWARD_POLICY="ACCEPT"/g' /etc/default/ufw
	
	#Initialize swarm and make it the default leader
	docker swarm init
	
	#Create development overlay network
	docker network create -d overlay development
	
	#Create portainer data folder
	mkdir -p /opt/docker/portainer/data

	#Deploy portainer
	docker stack deploy --compose-file portainer/docker-stack.yml portainer
	
	#
	# Jenkins user setup																		   
	#

	#Create jenkins user with a home directory
	useradd jenkins
	mkdir /home/jenkins
	chown jenkins: /home/jenkins

	#Set Jenkins password
	echo "jenkins:ea94e5a1b2be49d984e50e95e81097f2" | chpasswd

	#Make a docker loopback directory
	mkdir -p /opt/docker/jenkins/jenkins_slave
	chown jenkins: /opt/docker/jenkins/jenkins_slave
	chmod 777 /opt/docker/jenkins/jenkins_slave

	#Add user to docker group
	gpasswd -a jenkins docker

	#Restart docker for changes to take effect
	systemctl restart docker

	#
	# Jenkins install   
	#

	#Create a Jenkins home directory on host for access by docker group
	mkdir -p /opt/docker/jenkins/jenkins_home
	chmod 777 /opt/docker/jenkins/jenkins_home

	#Install java on host
	apt-get -y install default-jre
	java -version

	#Pull Jenkins image by way of initiating container
	docker stack deploy --compose-file jenkins/docker-stack.yml jenkins

	#
	# NGINX launch
	#

	#Create nginx directories for holding configuration files
	mkdir -p /opt/docker/nginx
	mkdir -p /opt/docker/nginx/conf.d
	mkdir -p /opt/docker/nginx/logs

	#Assign docker group ownership of nginx directories on host
	chgrp -R docker /opt/docker/nginx

	#Copy supplied configurations into respective nginx folder structure
	cp nginx/nginx.conf /opt/docker/nginx/nginx.conf
	cp nginx/conf.d/default.conf /opt/docker/nginx/conf.d/default.conf
	cp nginx/conf.d/jenkins.conf /opt/docker/nginx/conf.d/jenkins.conf

	#Launch docker container, exposed over port 80,  with supplied configuration mounted in read-only mode
	docker stack deploy --compose-file nginx/docker-stack.yml nginx
}

##########################################
# Adds a pre-configured Prometheus stack instance
# Arguments:
#   None
# Returns:
#   None
##########################################
add_monitoring_stack(){	
	mkdir -p /opt/docker/monitoring
	cp -r monitoring/prometheus /opt/docker/monitoring
	cp -r monitoring/grafana /opt/docker/monitoring
	chmod -R 777 /opt/docker/monitoring
	export DEPLOYMENT_NODE=$HOSTNAME
	docker stack deploy --compose-file monitoring/docker-stack.yml prometheus
}	
	
#######################################################################################
# Adds a docker system prune shell script into Ubuntu's existing weekly chron directory
# Arguments:
#   None
# Returns:
#   None
#######################################################################################
add_docker_auto_maintain(){

	#Add docker prune command into /etc/cron directory for automated maintenance purposes
	cp docker-prune.sh /etc/cron.weekly/docker-prune.sh
	
}
	
#############
# Adds Gitlab
# Arguments:
#   None
# Returns:
#   None
#############
add_gitlab(){
	
	#Permit traffic for GitLab
	ufw allow 10080
	ufw allow 10022
	
	#Add NGINX config for Gitlab
	cp nginx/conf.d/gitlab.conf /opt/docker/nginx/conf.d/gitlab.conf
	
	#
	# GitLab install
	#

	#Create data directories
	mkdir -p /opt/docker/gitlab
	mkdir -p /opt/docker/gitlab/data
	mkdir -p /opt/docker/gitlab/logs
	mkdir -p /opt/docker/gitlab/config
	chmod 777 -R /opt/docker/gitlab

	#Install GitLab image and run container
	docker run \
		-d \
		--name gitlab \
		-p 10080:80 -p 10022:22 \
		--env GITLAB_OMNIBUS_CONFIG="external_url 'http://localhost/gitlab';" \
		--restart always \
		-v /opt/docker/gitlab/config:/etc/gitlab:rw \
		-v /opt/docker/gitlab/logs:/var/log/gitlab:rw \
		-v /opt/docker/gitlab/data:/var/opt/gitlab:rw \
		gitlab/gitlab-ce:latest
}

#Initialise variables with empty string for idempotency purposes
gitlab=""
monitoring=""
docker_auto_maintain=""

#Grab additional features flag value from launch command
while [ $# -gt 0 ]; do
  case "$1" in
    --add-gitlab)
      gitlab=true
      ;;
	 --add-monitoring)
      monitoring=true
      ;;
	 --add-docker-auto-maintain)
      docker_auto_maintain=true
      ;;
	  --help)
      usage;
	  exit 1
	  ;;
    *)
	usage
  esac
  shift
done
	
#Trigger default install
default

#
# Command flag handlers
#
if [ ! -z ${gitlab} ] && [ ${gitlab} = true ]
then
	add_gitlab
fi

#Check for additional features - if present call installation method
if [ ! -z ${monitoring} ] && [ ${monitoring} = true ]
then
	add_monitoring_stack
fi

	
if [ ! -z ${docker_auto_maintain} ] && [ ${docker_auto_maintain} = true ]
then
	add_docker_auto_maintain
fi

	
#Allow 60 second sleep for applications to stabilise
sleep 60

#Reboot machine to ensure changes have been persisted
echo 'Rebooting machine to ensure changes have been persisted - please login to portainer to see Jenkins admin password in container log outputs'
reboot
