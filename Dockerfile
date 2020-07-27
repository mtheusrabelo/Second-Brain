FROM node:12.18.2-slim AS base
    ENV APPDIR /app
    EXPOSE $PORT
    WORKDIR $APPDIR
    ADD . $APPDIR

FROM base AS development
    ENTRYPOINT ["/app/entrypoint.sh"]

FROM base AS production
    ENV NODE_ENV production
    RUN yarn install --production
    RUN yarn run build
    CMD yarn run start
