#!/bin/bash
# Copyright (c) 2020 IBM Corp.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

MANIFESTS="/root/acmeair-manifests"
CLUSTER_DOMAIN=`oc -n openshift-ingress-operator get ingresscontrollers -o jsonpath='{.items[].status.domain}'`
ROUTE_HOST="acmeair.${CLUSTER_DOMAIN}"

echo "Route Host=${ROUTE_HOST}"
oc new-project acme-air
oc project acme-air

mkdir -p ${MANIFESTS}
cd ${MANIFESTS}
echo "Installing Acme-Air in acme-air namespace ..."
# Main service
curl -o acmeair-mainservice-route.yaml https://raw.githubusercontent.com/ocp-power-demos/acmeair-mainservice-java/master/manifests-openshift/acmeair-mainservice-route.yaml
curl -o deploy-acmeair-mainservice-java.yaml https://raw.githubusercontent.com/ocp-power-demos/acmeair-mainservice-java/master/manifests-openshift/deploy-acmeair-mainservice-java.yaml

# Auth service
curl -o acmeair-authservice-route.yaml https://raw.githubusercontent.com/ocp-power-demos/acmeair-authservice-java/master/manifests-openshift/acmeair-authservice-route.yaml
curl -o deploy-acmeair-authservice-java.yaml https://raw.githubusercontent.com/ocp-power-demos/acmeair-authservice-java/master/manifests-openshift/deploy-acmeair-authservice-java.yaml

# Customer service
curl -o acmeair-customerservice-route.yaml https://raw.githubusercontent.com/ocp-power-demos/acmeair-customerservice-java/master/manifests-openshift/acmeair-customerservice-route.yaml
curl -o deploy-acmeair-customerservice-java.yaml https://raw.githubusercontent.com/ocp-power-demos/acmeair-customerservice-java/master/manifests-openshift/deploy-acmeair-customerservice-java.yaml

# Flight service
curl -o acmeair-flightservice-route.yaml https://raw.githubusercontent.com/ocp-power-demos/acmeair-flightservice-java/master/manifests-openshift/acmeair-flightservice-route.yaml
curl -o deploy-acmeair-flightservice-java.yaml https://raw.githubusercontent.com/ocp-power-demos/acmeair-flightservice-java/master/manifests-openshift/deploy-acmeair-flightservice-java.yaml

# Booking service
curl -o acmeair-bookingservice-route.yaml https://raw.githubusercontent.com/ocp-power-demos/acmeair-bookingservice-java/master/manifests-openshift/acmeair-bookingservice-route.yaml
curl -o deploy-acmeair-bookingservice-java.yaml https://raw.githubusercontent.com/ocp-power-demos/acmeair-bookingservice-java/master/manifests-openshift/deploy-acmeair-bookingservice-java.yaml

# Update hostname in routes manifest
echo "Patch hostname for routes"
if [[ `grep -c ${ROUTE_HOST} ${MANIFESTS}/acmeair-mainservice-route.yaml` == 0 ]]
then
  sed -i "s@_HOST_@${ROUTE_HOST}@" ${MANIFESTS}/acmeair-mainservice-route.yaml
fi

if [[ `grep -c ${ROUTE_HOST} ${MANIFESTS}/acmeair-authservice-route.yaml` == 0 ]]
then
  sed -i "s@_HOST_@${ROUTE_HOST}@" ${MANIFESTS}/acmeair-authservice-route.yaml
fi

if [[ `grep -c ${ROUTE_HOST} ${MANIFESTS}/acmeair-customerservice-route.yaml` == 0 ]]
then
  sed -i "s@_HOST_@${ROUTE_HOST}@" ${MANIFESTS}/acmeair-customerservice-route.yaml
fi

if [[ `grep -c ${ROUTE_HOST} ${MANIFESTS}/acmeair-flightservice-route.yaml` == 0 ]]
then
  sed -i "s@_HOST_@${ROUTE_HOST}@" ${MANIFESTS}/acmeair-flightservice-route.yaml
fi

if [[ `grep -c ${ROUTE_HOST} ${MANIFESTS}/acmeair-bookingservice-route.yaml` == 0 ]]
then
  sed -i "s@_HOST_@${ROUTE_HOST}@" ${MANIFESTS}/acmeair-bookingservice-route.yaml
fi

oc create -f ${MANIFESTS}

echo "========================================================================"
echo "Acme Air Deployment complete. You can access the application now."
echo "NAMESPACE=acme-air"
echo "ACMEAIR URL=https://${ROUTE_HOST}/acmeair"
echo "========================================================================"
