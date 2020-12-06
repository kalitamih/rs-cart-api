FROM mhart/alpine-node as build

WORKDIR /app

COPY ./*.json ./

RUN npm install && npm cache clean --force

COPY ./src ./src

RUN npm run prebuild && npm run build


FROM mhart/alpine-node

WORKDIR /app

COPY package.json ./

RUN npm install --production && npm cache clean --force

COPY --from=build /app/dist ./dist

CMD [ "npm", "run", "start:prod" ]

EXPOSE 4000




