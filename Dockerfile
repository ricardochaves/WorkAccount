FROM node:14

RUN npm install -g truffle
RUN npm install -g truffle-assertions

RUN npm install @openzeppelin/contracts