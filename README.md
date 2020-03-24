## Intro

This image is for running [FoundryVTT](https://foundryvtt.com/) in docker and is based on the [Node 12 Alpine](https://hub.docker.com/_/node/) image. It currently works with verion 0.5.*

This is based on the work from https://github.com/mikysan/simple-fvtt-dockerfile

## Getting Started

First you need to download the latest linux foundryvtt build (link provided from Patreon.) Then you need to extract all the files into a directory you will mount in a volume with the docker container.

I use `/var/data/volume/foundry/fvtt` on my linux host and `/home/foundry/fvtt` in the container. So you will extract the contents of `foundryvtt-*.zip` into `/var/data/volume/foundry/fvtt` based on my setup.

## Basics

To run with persistent data (Keeps all changes between restarts) run the below command. Note the 2 volumes (-v *dir on host:dir in container*) attached. if you run it without the volumes/-v you will lose all data between restarts.

```
docker run --restart=always --name foundryvtt -p 30000:30000 \
-v /var/data/volume/foundry/fvtt:/home/foundry/fvtt \
-v /var/data/volume/foundry/data:/home/foundry/data \
-d spoctoss/foundryvtt
```

or with compose created `docker-compose.yml` file with below contents and then run `docker-compose up -d`. This requires you have [docker compose](https://docs.docker.com/compose/install/) installed as well.


```
version: '3.7'
services:
  vtt:
    restart: always
    ports:
      - '30000:30000'
    volumes:
      - /var/data/volume/foundry/fvtt:/home/foundry/fvtt
      - /var/data/volume/foundry/data:/home/foundry/data
    image: spoctoss/foundryvtt
```

I personally run this on docker swarm with traefik v2 as the proxy so I know it will work in that or similar setups.

### Volumes

Using volumes will allow you to persist your game data between reboots of the container or server it is running on.

* **/home/foundry/fvtt** - Directory where you would extract the linux release of the foundry zip file.
* **/home/foundry/data** - Directory where all your data ie. uploads game info and any customizations are stored (Keep this backed up)

## Conclusion

Once you have the container running you should be able to load the app in your broswer by going to http://*ip-of-server*:30000
