#!/bin/bash 


docker run -d --name n2n-supernode --restart always -p 3636:3636/udp -p 5645:5645/udp cuiyf/n2n-supernode:v2

docker run -d --privileged --network host --name n2n-edgenode cuiyf/n2n-edgenode:v2 -d n2n -c cyf -k 123456 -a 192.168.24.2 -l 10.0.0.2:3636 -v -f
