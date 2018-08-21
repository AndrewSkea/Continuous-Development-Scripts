# Prometheus Monitoring Stack

## Pre-install steps

To deploy the stack across nodes, copy this folder's contents to the remote target then run the create-bindings.sh script.
This will create folders and default configuration file settings to be used by the prometheus stack.

## Variables and settings

The following variables should be set before deploying the stack:

1. DEPLOYMENT_NODE (String) - This is the hostname of the node that will serve Prometheus, Alertmanager and Grafana. 
Note that all nodes will have the node-exporter and cadvisor containers deployed to them for metrics gathering.

2. GF_SECURITY_ADMIN_PASSWORD (String) - the default Grafana password that will be set for the admin user. If not set, 'admin' will be used.

## Deploying the stack

To deploy the stack run the following commands:

```
mkdir -p /opt/docker/monitoring
cp -r monitoring /opt/docker
chmod -R 777 /opt/docker/monitoring
export DEPLOYMENT_NODE=$HOSTNAME
docker stack deploy --compose-file monitoring/docker-stack.yml prometheus
```

As there is currently a known issue in placing the prometheus.yml configuration file into a docker config, if you want to change the deployment node to a different host,
you need to first run the above commands on your remote host, then change ```export DEPLOYMENT_NODE=$HOSTNAME``` to read ```export DEPLOYMENT_NODE=MCRISCD02``` replacing the
node name as suitable.