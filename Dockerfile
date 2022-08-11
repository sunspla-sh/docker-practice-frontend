# First stage of multi-step build process

FROM node:16-alpine as builder

WORKDIR '/usr/app'

COPY package.json .

RUN npm install

COPY . .

RUN npm run build

# Second stage of multi-step build process

FROM nginx

#AWS elastic beanstalk will use this to expose port 80 if we don't have a docker-compose.yml file.
#In our case we already exposed port 80 with our docker-compose.yml file, which we created because
#amazon switched to the Amazon Linux 2 Platform for AWS EBS which looks for a docker-compose.yml
#and uses it to build the single container app.
EXPOSE 80

COPY --from=builder /usr/app/dist /usr/share/nginx/html