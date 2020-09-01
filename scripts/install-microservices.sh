#!/bin/bash

if [ $# -lt 4 ]; then
  echo 1>&2 "Usage: $0 <DOCKER_REPO> <NAMESPACE> <HOSTDOMAIN> <VERSION>"
  exit 2
fi
DOCKER_REPO=$1
NAMESPACE=$2
HOSTDOMAIN=$3
VERSION=$4

helm install ./apps/redis/helm/ --set image.registry=${DOCKER_REPO} --set password=gRAHBwPjR8 --set cluster.enabled=false --set master.livenessProbe.enabled=false --set master.readinessProbe.enabled=false --name redis-demo --set image.repository=redis --set image.tag=${VERSION} --namespace ${NAMESPACE}
if [[ $? -ne 0 ]] ; then
    echo "error failed to install postgresql"
    exit 1
fi

helm install ./apps/webappdjango/helm/ --name webappdjango-demo --set ingress.hosts=${HOSTDOMAIN} --set image.repository=${DOCKER_REPO}/webappdjango --set image.tag=${VERSION} --namespace ${NAMESPACE}
if [[ $? -ne 0 ]] ; then
    echo "error failed to install webappreact"
    exit 1
fi

