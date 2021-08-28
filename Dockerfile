FROM node

MAINTAINER https://github.com/airdb

WORKDIR /srv

RUN git clone https://github.com/Redocly/redoc /srv/redoc
RUN cd /srv/redoc && \
 	npm install 

# Custom the configs.
RUN cd /srv/redoc && \
	sed -i '/port: 9090/i\   host: "0.0.0.0",' demo/webpack.config.ts && \
	sed -i "/const demos = /a\   { label: 'UIC', value: 'https://scf.baobeihuijia.com/test/uic/swagger/doc.json'}," demo/index.tsx


WORKDIR /srv/redoc

# Build
RUN npm run build:demo

# Github Pages
# git push --force "https://${{ secrets.GithubBotToken }}@github.com/${GITHUB_REPOSITORY}" master:gh-pages
RUN cd demo/ && \
	git init && \
        git config user.name "airdb-bot" && \
        git config user.email "airdb-bot@airdb.com" && \
        git add -A && \
        git commit -m "Auto Update by actions"


#CMD ["/bin/bash"]
#CMD npm run start:demo
#CMD ["npm", "run",  "start:demo"]
#CMD ["npm", "run",  "build:demo"]
