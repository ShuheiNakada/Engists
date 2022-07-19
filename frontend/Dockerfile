FROM node:16.13.2-alpine

ARG WORKDIR

ENV HOME=/${WORKDIR} \
    TZ=Asia/Tokyo

WORKDIR ${HOME}

RUN apk update && npm install -g npm

CMD ["npm", "run", "dev"]