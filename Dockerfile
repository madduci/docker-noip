FROM alpine:latest as builder

RUN apk add --no-cache rust cargo ca-certificates wget shadow &&  \
    useradd -s /bin/sh noipuser 

RUN cd /tmp && \
    wget https://www.noip.com/download/linux/latest && \
    tar -zxf latest && \
    cd noip-duc* && \
    cargo build --release && \
    cp target/release/noip-duc /usr/local/bin/noip-duc

FROM alpine:latest

LABEL maintainer="Michele Adduci <adduci@tutanota.com>" 

COPY ./docker-entry.sh /bin/

RUN apk add --no-cache musl libgcc

COPY --from=builder /usr/local/bin/noip-duc /usr/local/bin/
COPY --from=builder /etc/group /etc/
COPY --from=builder /etc/shadow /etc/
COPY --from=builder /etc/passwd /etc/

USER noipuser

ENTRYPOINT [ "/bin/docker-entry.sh" ]
