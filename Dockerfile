FROM node:16.15

MAINTAINER https://github.com/airdb

ENV DOMAIN "https://service-iw6drlfr-1251018873.sh.apigw.tencentcs.com"
WORKDIR /srv

RUN apt-get update && \
	apt-get install -y git
RUN git clone -b v2.0.0-rc.74 https://github.com/Redocly/redoc /srv/redoc
RUN cd /srv/redoc 
#&& \ npm install 

# Custom the configs.
RUN cd /srv/redoc && \
	sed -i '/port: 9090/i\   host: "0.0.0.0",' demo/webpack.config.ts && \
	sed -i "/const demos = /a\   { label: 'UIC', value: '${DOMAIN}/test/uic/swagger/doc.json'}," demo/index.tsx && \
	sed -i "/const demos = /a\   { label: 'Noah', value: '${DOMAIN}/test/noah/swagger/doc.json'}," demo/index.tsx && \
	sed -i "/const demos = /a\   { label: 'airdb', value: '${DOMAIN}/test/noah/swagger/doc.json'}," demo/index.tsx && \
	sed -i "/const demos = /a\   { label: 'Default', value: '${DOMAIN}/test/default/swagger/doc.json'}," demo/index.tsx && \
	sed -i "/const demos = /a\   { label: 'mp-bbhj', value: '${DOMAIN}/test/mina/docs/swagger.json'}," demo/index.tsx && \
	sed -i "/const demos = /a\   { label: 'Dev', value: 'http://airdb.me/docs/swagger.yaml'}," demo/index.tsx


WORKDIR /srv/redoc

# Build
#RUN npm run build:demo

# Github Pages
# git push --force "https://xxxxx@github.com/airdb-wiki/redoc" main:gh-pages
#RUN cd demo/dist && \
#	git init && \
#        git config user.name "airdb-bot" && \
#        git config user.email "airdb-bot@airdb.com" && \
#        git add -A && \
#        git commit -m "Auto Update by actions"


#CMD ["/bin/bash"]

#CMD npm run start:demo
#CMD ["npm", "run",  "build:demo"]
#CMD ["npm", "run",  "start:demo"]
