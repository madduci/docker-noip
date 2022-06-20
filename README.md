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

 * arm32v6
 * arm32v7
 * arm64v8
 * amd64
 * i386

## Quick Reference

### Creating the configuration file
In order to create the configuration file (i.e. `no-ip2.conf`), run the following command
```
docker run -it --rm \
  -v $(pwd):/usr/local/etc \
  madduci/docker-noip -C
```
An interactive wizard will ask every necessary information and it will generate the configuration file

### Running

#### Using a configuration file (recommended)
```
docker run -d \
  -v $(pwd)/no-ip2.conf:/usr/local/etc/no-ip2.conf:rw \
  madduci/docker-noip -d
```

#### Using noip2 command line

Program usage from noip2 help:

```
USAGE: noip2 [ -C [ -F][ -Y][ -U #min]
	[ -u username][ -p password][ -x progname]]
	[ -c file][ -d][ -D pid][ -i addr][ -S][ -M][ -h]

Version Linux-2.1.9
Options: -C               create configuration data
         -F               force NAT off
         -Y               select all hosts/groups
         -U minutes       set update interval
         -u username      use supplied username
         -p password      use supplied password
         -x executable    use supplied executable
         -c config_file   use alternate data path
         -d               increase debug verbosity
         -D processID     toggle debug flag for PID
         -i IPaddress     use supplied address
         -I interface     use supplied interface
         -S               show configuration data
         -M               permit multiple instances
         -K processID     terminate instance PID
         -z               activate shm dump code
         -h               help (this text)
```

Example
```
docker run -d \
  -v $(pwd)/no-ip2.conf:/usr/local/etc/no-ip2.conf:rw \
  madduci/docker-noip -d \
  -u <username> \
  -p <password> \
  -U [time-interval]
```

## License
MIT
