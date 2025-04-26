FROM node:18 AS builder

WORKDIR  /app

COPY package*.json ./

RUN npm install 


COPY . .

RUN npm run build


FROM node:18-slim

WORKDIR /app

COPY --from=builder /app/dist ./dist
COPY --from=builder /app/node_modules ./node_modules


ENV PORT=3000

EXPOSE 3000

CMD [ "node","dist/main" ]

