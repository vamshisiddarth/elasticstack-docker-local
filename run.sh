#!/usr/bin/env bash
echo "#####################################"
echo "#########  Stop Docker   ############"
echo "#####################################"
docker ps | grep sandbox | awk {'print $1'} | xargs docker stop
docker ps | grep sandbox | awk {'print $1'} | xargs docker rm
echo "#####################################"
echo "##  Clear Un-used Containers  #######"
echo "#####################################"
docker ps -a | grep Exited | awk {'print $1'} | xargs docker rm
echo "#####################################"
docker-compose down && docker-compose up -d --remove-orphans
echo "#####################################"
echo "#####  Deploy Sample Pods  ##########"
echo "#####################################"
kubectl apply -f sample-pods/sample-pods-deployment.yaml --kubeconfig=$HOME/.kube/config
echo "#####################################"
echo "########  Deploy Agents  ############"
echo "#####################################"
docker run -d \
  --name=metricbeat-sandbox \
  --user=root \
  --network="host" \
  --volume="$(pwd)/metricbeat.docker.yml:/usr/share/metricbeat/metricbeat.yml:ro" \
  --volume="/var/run/docker.sock:/var/run/docker.sock:ro" \
  --volume="/sys/fs/cgroup:/hostfs/sys/fs/cgroup:ro" \
  --volume="/proc:/hostfs/proc:ro" \
  --volume="/:/hostfs:ro" \
  docker.elastic.co/beats/metricbeat:7.8.0 metricbeat -e \
  -E output.elasticsearch.hosts=["localhost:9200"]
echo "#####################################"
echo "########  Deploy Complete  ##########"
echo "#####################################"
echo "http://localhost:5601"

sleep 60
curl  http://kubernetes.docker.internal:9200/_cat/indices\?v
