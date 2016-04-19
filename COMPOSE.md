# docker-hdp
Running an HDP cluster in docker containers with docker-compose

First [install the latest version of docker-compose](https://docs.docker.com/compose/install/)

# Running all containers on a single host
```
docker-compose -f local.yml up
```

If using docker-machine, get your docker VM's IP address and add hostnames to /etc/hosts
```
DOCKER_VM_IP=$(docker-machine ip default)
echo "$DOCKER_VM_IP ambari-server ambari-server.dev" >> /etc/hosts
echo "$DOCKER_VM_IP master0 master0.dev" >> /etc/hosts
echo "$DOCKER_VM_IP dn0 dn0.dev" >> /etc/hosts
```

After running the above, you should be able to access the Ambari web-ui at http://ambari-server.dev:8080
