#!/bin/sh

noip-duc --username $NOIP_USERNAME --password $NOIP_PASSWORD --hostnames $NOIP_HOSTNAMES @

cleanup() {
  echo "Caught Signal ... cleaning up."
  kill -s SIGINT $(pgrep noip-duc)
  echo "Done cleanup ... quitting."

  while pgrep noip-duc > /dev/null; do
    sleep 1;
  done

  exit 1
}

trap cleanup HUP INT QUIT PIPE TERM

# Wait for the noip-duc application to finish
while pgrep noip-duc > /dev/null; do
    sleep 1;
done
