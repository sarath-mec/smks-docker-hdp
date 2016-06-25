# Run from docker-hdp root
cd containers/node
docker build -t node .
cd ../ambari-server
docker build -t ambari-server .
cd ../postgres
docker build -t pgsql .
cd ..
