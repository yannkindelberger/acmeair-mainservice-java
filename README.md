
## Acme Air Main Service - Java/Liberty

An implementation of the Acme Air Main Service for Java/Liberty. The main service primarily consists of the presentation layer (web pages) that interact with the other services.

This implementation can support running on a variety of runtime platforms including standalone bare metal system, Virtual Machines, docker containers, IBM Cloud, IBM Cloud Private, and other Kubernetes environments.

## Full Benchmark Installation Instructions on various docker enviornments.
![alt text](https://github.com/blueperf/acmeair-mainservice-java/blob/master/images/AcmeairMS.png "AcmeairMS Java")

## Installing Acme Air on Openshift 4.x

Podman Environment
```
$ yum install podman maven git -y

$ mkdir acme-air
$ cd acme-air
$ git clone https://github.com/yigitpolat/acmeair-mainservice-java.git
$ git clone https://github.com/yigitpolat/acmeair-authservice-java.git
$ git clone https://github.com/yigitpolat/acmeair-customerservice-java.git
$ git clone https://github.com/yigitpolat/acmeair-flightservice-java.git
$ git clone https://github.com/yigitpolat/acmeair-bookingservice-java.git

$ cd acmeair-mainservice-java
$ mvn clean package
$ podman build -t docker.io/yigitpolat/acmeair-mainservice-java:$(uname -m) --format docker -f Dockerfile .
$ podman push docker.io/yigitpolat/acmeair-mainservice-java:$(uname -m)

$ cd ../acmeair-authservice-java
$ mvn clean package
$ podman build -t docker.io/yigitpolat/acmeair-authservice-java:$(uname -m) --format docker -f Dockerfile .
$ podman push docker.io/yigitpolat/acmeair-authservice-java:$(uname -m)

$ cd ../acmeair-customerservice-java
$ mvn clean package
$ podman build -t docker.io/yigitpolat/acmeair-customerservice-java:$(uname -m) --format docker -f Dockerfile .
$ podman push docker.io/yigitpolat/acmeair-customerservice-java:$(uname -m)

$ cd ../acmeair-flightservice-java
$ mvn clean package
$ podman build -t docker.io/yigitpolat/acmeair-flightservice-java:$(uname -m) --format docker -f Dockerfile .
$ podman push docker.io/yigitpolat/acmeair-flightservice-java:$(uname -m)

$ cd ../acmeair-bookingservice-java
$ mvn clean package
$ podman build -t docker.io/yigitpolat/acmeair-bookingservice-java:$(uname -m) --format docker -f Dockerfile .
$ podman push docker.io/yigitpolat/acmeair-bookingservice-java:$(uname -m)

$ oc login -u <username> -p <password> <api-endpoint>

$ cd ../acmeair-mainservice-java/scripts
$ sh deployToOpenShift.sh

$ curl --insecure https://acmeair.apps.test.cluster.tr.com:443/booking/loader/load
$ curl --insecure https://acmeair.apps.test.cluster.tr.com:443/flight/loader/load
$ curl --insecure https://acmeair.apps.test.cluster.tr.com:443/customer/loader/load?numCustomers=10000

```