AMBARI_HOST=localhost:8080
curl --user admin:admin -H 'X-Requested-By:admin' -X POST $AMBARI_HOST/api/v1/blueprints/multi-container --data-binary "@blueprints/multi-container.json"
curl --user admin:admin -H 'X-Requested-By:admin' -X POST $AMBARI_HOST/api/v1/clusters/dev --data-binary "@hostgroups/multi-container.json"
