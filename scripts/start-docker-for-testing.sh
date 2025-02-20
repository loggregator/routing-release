#!/bin/bash -x

BASEDIR="$(cd $(dirname "$0") && pwd)"
ROUTING_RELEASE_DIR="${BASEDIR}/.."

IMAGE="cloudfoundry/tas-runtime-mysql-8.0"
DB="mysql"
MOUNT_DIR="/routing-release"
PREPARE_CONTAINER="export DB=${DB}; cd ${MOUNT_DIR}; source .envrc; scripts/setup-test-environment.sh; bash"

docker pull "${IMAGE}"
docker run -it \
  -v "${ROUTING_RELEASE_DIR}:${MOUNT_DIR}" \
  -e "GOFLAGS=-buildvcs=false" \
  "${IMAGE}" \
  /bin/bash -c "${PREPARE_CONTAINER}"

