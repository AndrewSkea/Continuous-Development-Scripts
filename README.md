# Informed-CD-Scripts
Scripts repository for automatically configuring CI/CD pipeline components.

## Usage

All scripts assume you are using Ubuntu Server and have access to the internet. To execute scripts change to the assets directory.

### pipeline-setup-cd-controller.sh
> Used to create a master CI/CD controller. Components include Shipyard, a Docker Registry, Jenkins and NGINX.
To setup a basic master CI/CD controller, execute the following command `sh pipeline-setup-cd-controller.sh`. 

To see guidance on flags that can be supplied at runtime execute `sh pipeline-setup-cd-controller.sh --help`. Flags that are currently accepted include:
1. --add-gitlab: launches a Gitlab community edition container (available at http://host/gitlab)
2. --add-monitoring: launches a pre-configured ELK stack built on docker containers (available at http://host/kibana). Includes pre-configured packetbeat, metricbeat and filebeat installations on your host and imports example dashboards into Kibana.
3. --add-docker-auto-maintain: Adds a docker system prune script into the Ubuntu weekly chron schedule

### pipeline-add-node.sh
> Adds a node to your pipeline that can be used as a Jenkins slave/Docker cluster node. Installs shipyard node components and creates Jenkins directories. 

To see guidance on flags that can be supplied at runtime execute `sh pipeline-add-node.sh --help`. Flags that are currently accepted include:
1. -sl: A required flag which sets the Swarm leader IP address
2. --add-beats-base-install: An optional flag to install filebeat, metricbeat and packetbeat. These will require manual configuration after installation.

### docker-prune.sh
> Removes dangling docker volumes, containers and images. This script is loaded into the Ubuntu weekly chron schedule directory if the --add-docker-auto-maintain flag is supplied when setting up your CI/CD controller.

### pipeline-destroy.sh
> Removes all pipeline components.
