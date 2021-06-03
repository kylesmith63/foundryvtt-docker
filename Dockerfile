FROM node:14-alpine

ENV UID=1000
ENV GUID=1000

RUN deluser node
RUN addgroup -g $GUID foundry \
    && adduser -u $UID -G foundry -s /bin/sh -D foundry

USER foundry

RUN mkdir -p /home/foundry/fvtt
RUN mkdir -p /home/foundry/data

WORKDIR /home/foundry/fvtt

EXPOSE 30000
CMD [ "node", "resources/app/main.js", "--headless", "--dataPath=/home/foundry/data" ]
