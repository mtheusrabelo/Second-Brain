FROM postgres:13-alpine AS base

FROM base AS development
    ARG MUID
    ARG MGID
    ADD ./DB.backup.sh /
    RUN mkdir -p /backups
    RUN addgroup -g $MGID -S appuser && \
        adduser -u $MUID -S appuser -G appuser
    RUN chown -R appuser:appuser $PGDATA
    RUN chown -R appuser:appuser /backups
    CMD ["postgres"]
