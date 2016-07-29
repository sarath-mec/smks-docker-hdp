# docker-hdp

Install the latest version of [Docker for Mac](https://docs.docker.com/engine/installation/mac/#/docker-for-mac). Older versions of Docker provided by docker-machine and/or Docker Toolbox will not work.

These containers are not pushed to DockerHub, thus you'll need to build them locally:
```
docker-compose -f examples/compose/single-container.yml build
```

A successful build looks like:
```
docker-hdp randy> docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
hdp/node            latest              cacb20b1b0d3        15 seconds ago      7.682 GB
hdp/ambari-server   latest              b0fad41dd49c        15 minutes ago      2.492 GB
hdp/postgres        latest              ad42250d5c8b        23 minutes ago      320.2 MB
centos              6                   cf2c3ece5e41        3 weeks ago         194.6 MB
postgres            latest              7ee9d2061970        6 weeks ago         275.3 MB
```

##Running HDP 2.5 Tech Preview:
To run 3 containers (postgres, ambari-server, and a single container HDP cluster):
```
docker-compose -f examples/compose/single-container.yml up
```

After a minute or so, you should be able to access Ambari's Web UI at localhost:8080. Default User/PW is admin/admin as usual.

##Using Ambari Blueprints:
To snapshot your cluster's configuration into a blueprint:
```
# You can extract a blueprint as soon as you click Deploy. No need to wait for install to complete.
curl --user admin:admin -H 'X-Requested-By:admin' localhost:8080/api/v1/clusters/dev?format=blueprint > examples/blueprints/single-container.json 
```

To submit your blueprint to Ambari and have it install your cluster:
```
# Can swap "single-container" for multi-container, or any type saved in examples/blueprints and examples/hostgroups
sh submit-blueprint.sh single-container
```

##Notes:
1. Ambari, Hive, and Ranger dbs have been pre-created in the postgres database running at postgres.dev. To configure them in Ambari, set Postgres as the DB type and leave everything else as the default options. The password for the dbs are all "dev". ![Example][screenshots/hive-setup.png?raw=true]
2. The "node" container can be used for master, worker, or both types of services. The ambari-agent is configured to register with ambari-server.dev automatically, thus no SSH key setup is necessary. Use dn0.dev (and master0.dev if using multi-container) ![Example][screenshots/cluster-hosts.png?raw=true]
3. Yum packages for all HDP services have been pre-installed in the "node" container. This lets cluster install take place much faster at the expense of a spurious warning from Ambari during Host-Checks.
4. All Ambari and HDP repositories are downloaded at buildtime. The versions and URLs are specified in .env in the project's root

##Helpful Hints:
The postgres container has an attached volume. If you want to toss the volume:
```
randy$ docker volume ls
DRIVER              VOLUME NAME
local               39fe77c7c5b7e319109d8b63912f3b75add8e6a911537f03cbf4c1b81239ce1b
randy$ docker volume rm 39fe77c7c5b7e319109d8b63912f3b75add8e6a911537f03cbf4c1b81239ce1b
Error response from daemon: Unable to remove volume, volume still in use: remove 39fe77c7c5b7e319109d8b63912f3b75add8e6a911537f03cbf4c1b81239ce1b: volume is in use - [a616026f5ce77b75f12d956cc4c1e4125ae192054c4f1c1e6472424738583725]
randy$ docker rm -f a616026f5ce77b75f12d956cc4c1e4125ae192054c4f1c1e6472424738583725
a616026f5ce77b75f12d956cc4c1e4125ae192054c4f1c1e6472424738583725
randy$ docker volume rm 39fe77c7c5b7e319109d8b63912f3b75add8e6a911537f03cbf4c1b81239ce1b
39fe77c7c5b7e319109d8b63912f3b75add8e6a911537f03cbf4c1b81239ce1b
```

Docker for Mac sometimes has storage space problems. I recommend adding the following to your ~/.bash_profile and restarting terminal:
```
function docker-cleanup(){
 # remove untagged images  
 docker rmi $(docker images | grep none | awk '{ print $3}')
 # remove unused volumes  
 docker volume rm $(docker volume ls -q )  
 # `shotgun` remove unused networks
 docker network rm $(docker network ls | grep "_default")   
 # remove stopped + exited containers, I skip Exit 0 as I have old scripts using data containers.
 docker rm -v $(docker ps -a | grep "Exit [0-255]" | awk '{ print $1 }')
}
```

Run "docker-cleanup" if you run into Docker errors or "No space left on device" issues inside containers.

Since Hadoop UIs often link to hostnames, add the following to your hosts file:
```
echo "127.0.0.1 ambari-server ambari-server.dev" >> /etc/hosts
echo "127.0.0.1 master0 master0.dev" >> /etc/hosts
echo "127.0.0.1 dn0 dn0.dev" >> /etc/hosts
```

TODO:
1. Steps for using latest Docker 1.12 Swarm & Compose on multiple hosts
