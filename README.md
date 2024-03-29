NoIP
======

[![License](	https://img.shields.io/github/license/madduci/docker-noip.svg)](LICENSE)

[![Image Details](https://images.microbadger.com/badges/image/madduci/docker-noip.svg)](https://microbadger.com/images/madduci/docker-noip)
[![Docker Pulls](	https://img.shields.io/docker/pulls/madduci/docker-noip.svg)](https://hub.docker.com/r/madduci/docker-noip)
[![Last commit](	https://images.microbadger.com/badges/commit/madduci/docker-noip.svg)](https://microbadger.com/images/madduci/docker-noip)
[![Docker Stars](	https://img.shields.io/docker/stars/madduci/docker-noip.svg)](https://hub.docker.com/r/madduci/docker-noip)

## Useful links
* [Docker Hub](https://hub.docker.com/r/madduci/docker-noip)
* [GitHub](https://github.com/madduci/docker-noip)

## What is NoIP?

NoIP is a dynamic DNS service. You can access your dynamic IP address machines with the service. [Know more](https://www.noip.com)

There is client to update the dynamic DNS IP called DUC (Dynamic Update Client).

From DUC [Download page](https://www.noip.com/download):

> Our Dynamic DNS Update Client continually checks for IP address changes in the background and automatically updates the DNS at No-IP whenever it changes.
>
> ✔ Command Line Interface
>
> ✔ Quick & Easy Setup
>
> ✔ Widely Compatible
>
> ✔ Auto Host List Download
>
> ✔ Runs When Logged Out
>
> ✔ Open Source

## About This Image

This is multi architecture docker image for the [NoIP](https://www.noip.com) DUC (Dynamic Update Client)

### Supported Architectures

 * arm64v8
 * amd64
 * i386

## Quick Reference

### Building from Sources

Using `docker buildx`, all you need to do is to run the following command:

```sh
docker buildx build --platform linux/amd64,linux/386,linux/arm64 -t madduci/docker-noip .  --push
```

### Running

You need to specify the following environment variables:

- NOIP_HOSTNAMES as a comma-separated list of domains in No-Ip
- NOIP_USERNAME
- NOIP_PASSWORD

Example:

```sh
docker run -d \
  --env NOIP_HOSTNAMES=my_domain \
  --env NOIP_USERNAME=yourname \
  --env NOIP_PASSWORD=yourpassword \
  madduci/docker-noip \
  --check-interval [time-interval - default 5m]
```

## License

MIT
