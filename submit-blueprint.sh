# Type must be "single-container" or "multi-container"
TYPE=$1
AMBARI_HOST=localhost:8080
BASE_URL=http://public-repo-1.hortonworks.com/HDP-LABS/Projects/Erie-Preview/2.5.0.0-4/centos6/
curl --user admin:admin -H 'X-Requested-By:admin' -X POST $AMBARI_HOST/api/v1/blueprints/multi-container --data-binary "@examples/blueprints/$TYPE.json"
curl --user admin:admin -H 'X-Requested-By:admin' -X PUT $AMBARI_HOST/api/v1/stacks/HDP/versions/2.5/operating_systems/redhat6/repositories/HDP-2.5 -d '{"Repositories":{"base_url":"'$BASE_URL'", "verify_base_url":true}}'
curl --user admin:admin -H 'X-Requested-By:admin' -X POST $AMBARI_HOST/api/v1/clusters/dev --data-binary "@examples/hostgroups/$TYPE.json"
