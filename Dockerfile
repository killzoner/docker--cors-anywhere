FROM node:16.13-buster-slim AS builder

ENV GIT_COMMIT 70aaa22b3f9ad30c8566024bf25484fd1ed9bda9

WORKDIR /app
RUN npm install -s https://github.com/Rob--W/cors-anywhere#${GIT_COMMIT}

FROM node:16.13-buster-slim

COPY --from=builder /app/node_modules /app/node_modules
COPY --from=builder --chown=node:node /app /app

WORKDIR /app

ENV NODE_ENV production

USER node

EXPOSE 8080

ENTRYPOINT ["docker-entrypoint.sh"]

CMD [ "node", "node_modules/cors-anywhere/server.js" ]
