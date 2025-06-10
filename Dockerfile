FROM node:18.20.8
WORKDIR /apps
COPY ./apps/ .
RUN npm run install
CMD ["npm", "start"]