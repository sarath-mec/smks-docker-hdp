# Stop named containers if they're already running
docker stop ambari-server node0 postgres
# Purge named existing containers
docker rm -f ambari-server node0 postgres

# If using Docker for Mac, Ambari's web UI should be available on localhost:8080 a few minutes after the below completes
docker run -d --net dev --name postgres --hostname postgres pgsql
docker run -d -p 8080:8080 --net dev --name ambari-server --hostname ambari-server ambari-server sh /start.sh
# This node is configured to pre-register with Ambari as a cluster node. Thus keyless-ssh isn't necessary for node0.dev
docker run -d --net dev --name node0 --hostname node0.dev node sh /start.sh
