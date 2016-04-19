# docker-hdp
Dockerized HDP Cluster

I have 3 physical nodes: a laptop (n1), a desktop (n2), and a server (n3)

To create an HDP cluster using docker-compose, see [here](COMPOSE.md).

First [install the latest docker-engine](https://docs.docker.com/engine/installation/linux/centos/) (docker -v: 1.10 minimum) and Linux (uname -a: 3.10 minimum required for multi-host 'overlay' networking).

Next [install the latest version of consul](https://www.consul.io/downloads.html) and start at least one agent in server mode:
```
consul agent -server -data-dir /tmp/consul -bootstrap -bind $N1 -client $N1 > ~/consul-server.log & 2>&1
```

Edit your /etc/systemd/system/docker.service.d/docker.conf to work with your consul server. Set each host's --cluster-advertise val according to its IP address.
```
[Service]
ExecStart=
ExecStart=/usr/bin/docker daemon -H fd:// -H tcp://0.0.0.0:2375 --cluster-store consul://192.168.1.1:8500 --cluster-advertise 192.168.1.1:2375
```

Restart systemctl and the docker service to pick up the changes
```
sudo systemctl daemon-reload
sudo service docker restart
```

Start your swarm and create an overlay network:
```
N1=192.168.1.1
N2=192.168.1.2
N3=192.168.1.3
CONSUL=$N1:8500

if [ $(hostname) = "n1" ]; then
  #Start the swarm manager and swarm node
  docker run -d -p 4000:4000 swarm manage -H :4000 --replication --advertise $N1:4000 consul://$CONSUL
  docker run -d swarm join --advertise=$N1:2375 consul://$CONSUL
  docker -H :4000 network create --driver overlay dev
fi
if [ $(hostname) = "n2" ]; then
  #Start the swarm failover manager, and swarm node
  docker run -d -p 4000:4000 swarm manage -H :4000 --replication --advertise $N2:4000 consul://$CONSUL
  docker run -d swarm join --advertise=$N2:2375 consul://$CONSUL
fi

if [ $(hostname) = "n3" ]; then
  #Start the swarm node
  docker run -d swarm join --advertise=$N3:2375 consul://$CONSUL
fi
```

Start your containers:
```
if [ $(hostname) = "n1" ]; then
  docker build -t randerzander/postgres docker-hdp/containers/postgres
  docker build -t randerzander/ambari-server docker-hdp/containers/ambari-server
  docker build -t randerzander/node docker-hdp/containers/node

  docker run -d --net dev --name postgres randerzander/postgres
  docker run -d -p 8080:8080 --net dev --name ambari-server --hostname ambari-server.dev randerzander/ambari-server /start.sh
  docker run -d -P --net dev --name master0 --hostname master0.dev randerzander/node /start.sh
fi

if [ $(hostname) = "n2" ]; then
  docker build -t randerzander/node docker-hdp/containers/node
  docker run -d -P --net dev --name dn0 --hostname dn0.dev randerzander/node /start.sh
fi

if [ $(hostname) = "n3" ]; then
  docker build -t randerzander/node docker-hdp/containers/node
  docker run -d -P --net dev --name dn1 --hostname dn1.dev randerzander/node /start.sh
fi
```

When the above is complete, you should be able to access Ambari's web UI on $N1:8080 and install your cluster on nodes master0.dev, dn0.dev and dn1.dev
