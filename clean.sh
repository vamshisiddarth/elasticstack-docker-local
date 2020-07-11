#!/usr/bin/env bash
echo "#####################################"
echo "##  Clear Un-used Containers  #######"
echo "#####################################"
docker ps -a | grep Exited | awk {'print $1'} | xargs docker rm
echo "#####################################"
echo "#########  Stop Docker   ############"
echo "#####################################"
docker ps | grep elasticsearch | awk {'print $1'} | xargs docker stop
docker ps | grep filebeat | awk {'print $1'} | xargs docker stop
docker ps | grep metricbeat | awk {'print $1'} | xargs docker stop
docker ps | grep kibana | awk {'print $1'} | xargs docker stop
echo "#####################################"
echo "#########  Delete Pods   ############"
echo "#####################################"
kubectl delete -f sample-pods/sample-pods-deployment.yaml --kubeconfig=$HOME/.kube/config
