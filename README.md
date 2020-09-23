
## Acme Air Main Service - Java/Liberty

An implementation of the Acme Air Main Service for Java/Liberty. The main service primarily consists of the presentation layer (web pages) that interact with the other services.

This implementation can support running on a variety of runtime platforms including standalone bare metal system, Virtual Machines, docker containers, IBM Cloud, IBM Cloud Private, and other Kubernetes environments.

## Full Benchmark Installation Instructions on various docker enviornments.
![alt text](https://github.com/blueperf/acmeair-mainservice-java/blob/master/images/AcmeairMS.png "AcmeairMS Java")

## Installing Acme Air on Openshift 4.x

```
$ git clone https://github.com/ocp-power-demos/acmeair-mainservice-java
$ cd acmeair-mainservice-java
$ ./scripts/deployToOpenshift.sh
```
Access the application when all the pods are in Running state:
```
$ oc get pods
NAME                                      READY   STATUS    RESTARTS   AGE
acmeair-authservice-58459f88c9-bdmt6      1/1     Running   0          2m50s
acmeair-booking-db-66d696dfd4-5lw7k       1/1     Running   0          2m50s
acmeair-bookingservice-7fdd8789c4-6h28l   1/1     Running   0          2m50s
acmeair-customer-db-6f4d998ffb-qfb9w      1/1     Running   0          2m50s
acmeair-customerservice-fffd899d5-27jb7   1/1     Running   0          2m50s
acmeair-flight-db-54684fb648-sdvsl        1/1     Running   0          2m50s
acmeair-flightservice-5566cc7d79-vnqgx    1/1     Running   0          2m50s
acmeair-mainservice-7f846794d5-5nmk4      1/1     Running   0          2m50s
```
## Uninstalling the application
The deployment of Acme Air creates the manifests file in the /root/acmeair-manifests directory. To uninstall the application, run the following command:
```
oc delete -f acmeair-manifests
```
