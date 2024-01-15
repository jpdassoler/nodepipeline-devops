FROM node:12
RUN sed -i '/security.debian.org\/debian-security/d' /etc/apt/sources.list
RUN sed -i '/deb.debian.org\/debian/d' /etc/apt/sources.list
RUN apt-get update && apt-get install git -y && apt-get install imagemagick -y;

WORKDIR /ecs-app

COPY package*.json ./
COPY . .

RUN npm install
RUN chown -R node:node /ecs-app

ENV NODE_ENV=production
ENV ENV_ECS=true
USER root
EXPOSE 80

ENTRYPOINT ["npm", "start"]
