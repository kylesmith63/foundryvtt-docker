FROM node:12-alpine

ENV UID=1000
ENV GUID=1000

RUN deluser node
RUN addgroup -g $GUID foundry \
    && adduser -u $UID -G foundry -s /bin/sh -D foundry

USER foundry

RUN mkdir -p /home/foundry/app
RUN mkdir -p /home/foundry/data

WORKDIR /home/foundry/app

EXPOSE 30000
CMD [ "node", "resources/app/main.js", "--headless", "--dataPath=/home/foundry/data" ]
