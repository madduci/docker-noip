FROM alpine:latest as builder

RUN apk add --no-cache make g++ ca-certificates wget shadow &&  \
    useradd -s /bin/sh noipuser 

RUN cd /tmp && \
    wget -c http://www.noip.com/client/linux/noip-duc-linux.tar.gz && \
    tar -zxf noip-duc-linux.tar.gz && \
    NOIP_VERSION=$(find . -maxdepth 1 -mindepth 1 -type d -name 'noip*' | cut -d "-" -f2-) && \
    cd noip-${NOIP_VERSION} && \
    make && \
    cp /tmp/noip-${NOIP_VERSION}/noip2 /usr/bin/noip2

FROM alpine:latest

LABEL maintainer="Michele Adduci <adduci@tutanota.com>" 

COPY ./docker-entry.sh /bin/

COPY --from=builder /usr/bin/noip2 /usr/bin/
COPY --from=builder /etc/group /etc/
COPY --from=builder /etc/shadow /etc/
COPY --from=builder /etc/passwd /etc/

USER noipuser

ENTRYPOINT [ "/bin/docker-entry.sh" ]
