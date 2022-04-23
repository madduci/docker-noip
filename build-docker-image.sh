#!/bin/bash
set -euxo pipefail

. functions.sh

docker run \
  --rm \
  --privileged \
  multiarch/qemu-user-static:register \
  --reset

VERSION=$(get_noip_duc)

# build image
docker build \
  -t madduci/docker-noip:${VERSION}-$(get_arch "${ARCH}") \
  --build-arg BUILD_DATE=$(date -u +"%Y-%m-%dT%H:%M:%SZ") \
  --build-arg ARCH=$(get_arch "${ARCH}") \
  --build-arg VCS_REF=$(git rev-parse --short HEAD) \
  --build-arg QEMU=qemu-${ARCH}-static \
  --build-arg VERSION=${VERSION} \
  .

# test image
NOIP_VERSION=$(docker run --rm \
  -v $(pwd)/qemu-${ARCH}-static:/usr/bin/qemu-${ARCH}-static \
  madduci/docker-noip:${VERSION}-$(get_arch "$ARCH") \
  /usr/bin/noip2 -h 2>&1 |
  grep -E "^Version" |
  cut -d"-" -f2)

docker tag \
  madduci/docker-noip:${VERSION}-$(get_arch "$ARCH") \
  madduci/docker-noip:$(get_arch "$ARCH")

if [[ "${TRAVIS_PULL_REQUEST:-}" == "false" ]] && [[ "${TRAVIS_BRANCH:-}" == "master" ]]; then
  EXISTS=$(curl --silent -f -lSL https://hub.docker.com/v2/repositories/madduci/docker-noip/tags | jq "[.results | .[] | .name == \"$VERSION\"] | any" -r)
  if [ "$EXISTS" == "false" ] || [ "$TRAVIS_EVENT_TYPE" != "cron" ]; then
    echo "$DOCKER_PASS" | docker login --username "$DOCKER_USER" --password-stdin
    docker push madduci/docker-noip
  fi
fi
