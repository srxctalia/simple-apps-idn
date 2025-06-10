FROM node:18.20.8
WORKDIR /apps
COPY . .
RUN npm run install
CMD ["npm", "start"]