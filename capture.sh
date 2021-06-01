#!/bin/bash

# capture all traffic of a certain container

CONTAINER=server

docker run -it --net=container:$CONTAINER -v $PWD/tcpdump:/tcpdump kaazing/tcpdump -C 100 -v -w /tcpdump/$CONTAINER.pcap