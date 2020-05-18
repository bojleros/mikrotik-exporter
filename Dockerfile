FROM alpine:3.11 as builder

WORKDIR /app-build
COPY . .
RUN apk add --no-cache --virtual .build-deps bash gcc musl-dev openssl go \
    && go build  .


FROM alpine:3.11
WORKDIR /app/
EXPOSE 9436
COPY --from=builder /app-build/mikrotik-exporter .
RUN chmod 755 /app/*
ENTRYPOINT ["./mikrotik-exporter"]
