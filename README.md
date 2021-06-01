# BACnet Tools in Docker

This is a simple packaging of the [BACnet Protocol Stack](https://sourceforge.net/projects/bacnet) into a Docker image. Once there it's simple to simulate a network of BACnet/IP clients and servers of various types, each in their own container, specified by a Docker Compose file.

It's instructive to observe the traffic between containers with Wireshark or tcpdump.

## Usage

The Compose file is prepared to build and run the containers:

```
$ docker-compose up -d
```

To separately build the `bacnet` container run

```
$ docker build -t bacnet .
```

You can then observe logs from all of them like this:

```
$ docker-compose logs
Attaching to bacnet_whois_1, bacnet_server1_1, bacnet_server2_1, bacnet_server3_1
whois_1    | Received I-Am Request from 200002, MAC = 172.17.0.3 BAC0
whois_1    | Received I-Am Request from 200001, MAC = 172.17.0.4 BAC0
whois_1    | Received I-Am Request from 200003, MAC = 172.17.0.2 BAC0
whois_1    | ;Device   MAC (hex)            SNET  SADR (hex)           APDU
whois_1    | ;-------- -------------------- ----- -------------------- ----
whois_1    |   200002  AC:11:00:03:BA:C0    0     00                   1476 
whois_1    |   200001  AC:11:00:04:BA:C0    0     00                   1476 
whois_1    |   200003  AC:11:00:02:BA:C0    0     00                   1476 
whois_1    | ;
whois_1    | ; Total Devices: 3
```

To capture the traffic of a container have a look at [capture.sh](capture.sh).

You can also issue commands as needed from a new, transient container:

```
$ docker run -it bacnet bacwi
$ docker run -it bacnet bacepics -v 200002
etc
```

See the [BACnet stack bin documentation](https://sourceforge.net/p/bacnet/code/HEAD/tree/branches/releases/bacnet-stack-0-8-0/bin/readme.txt) for ideas.

Next, stand up several servers by editing docker-compose.yml for desired number of servers, clients, and device IDs, then:

