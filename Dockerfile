FROM alpine:latest

EXPOSE 8081

RUN apk --update add \
    curl \
    tzdata \
    ca-certificates \
    && rm -rf /var/cache/apk/* \

    ENV TZ=Asia/Jakarta

ADD bin/cicd /

HEALTHCHECK --interval=10s --timeout=5s --start-period=10s --retries=5 CMD curl -sSf http://127.0.0.1:8081/health

ENTRYPOINT ["./cicd"]
