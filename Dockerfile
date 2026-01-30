FROM node:24.12-alpine3.23 AS runtime

WORKDIR /gestionale-corsi-be

COPY package*.json ./
RUN npm ci

COPY . .

ENV PORT=3000

RUN mkdir ./logs
RUN npm run database:create-migration
RUN npm run database:migrate
RUN npm run database:seed

EXPOSE 3000

CMD ["npm", "run", "start:compile"]