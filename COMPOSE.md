# docker-hdp
Running an HDP cluster in docker containers with docker-compose

First [install the latest version of docker-compose](https://docs.docker.com/compose/install/).

To run all containers on a single host:
```
docker-compose -f local.yml up
```

To have Ambari install components for you:
```
sh scripts/submit-blueprint.sh
```

If manually configuring your cluster, note that the ambari agents are configured to automatically register with ambari-server. Configure them during cluster install as indicated below:
![cluster-hosts](/screenshots/cluster-hosts.png?raw=true)

Additionally, postgres.dev has a pre-configured databases for Hive and Ranger. Configure Hive like the below (password is 'dev'):
![hive-setup](/screenshots/hive-setup.png?raw=true)

If using Docker for Mac or Windows, add the following to your hosts file:
```
echo "127.0.0.1 ambari-server ambari-server.dev" >> /etc/hosts
echo "127.0.0.1 master0 master0.dev" >> /etc/hosts
echo "127.0.0.1 dn0 dn0.dev" >> /etc/hosts
```

If using docker-machine, get your docker VM's IP address and add hostnames to /etc/hosts
```
DOCKER_VM_IP=$(docker-machine ip default)
echo "$DOCKER_VM_IP ambari-server ambari-server.dev" >> /etc/hosts
echo "$DOCKER_VM_IP master0 master0.dev" >> /etc/hosts
echo "$DOCKER_VM_IP dn0 dn0.dev" >> /etc/hosts
```

After running the above, you should be able to access the Ambari web-ui at http://ambari-server.dev:8080

TODO: Above, but using docker-swarm for multi-host deployment
