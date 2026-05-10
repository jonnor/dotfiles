#/bin/bash -xe

set -euxo pipefail

DOCKER_TAG=emlearn-micropython-dev:latest
WORKSPACE_DIR=/home/jon/projects/emlearn-micropython

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [[ -z "${OPENROUTER_API_KEY}" ]]; then
  echo "Error: OPENROUTER_API_KEY is not set" >&2
  exit 1
fi

if [[ -z "${LLAMA_API_KEY_JON_WORKSTATION}" ]]; then
  echo "Warning: LLAMA_API_KEY_JON_WORKSTATION is not set" >&2
  #exit 1
fi

# rebuild docker image (if needed)
cd $DIR
cp $WORKSPACE_DIR/requirements*.txt ./
podman build . -t $DOCKER_TAG

# XXX: no-aaaa was critical to avoid AAAA IPv6 lookups on mDNS failing
# and causing huge lags
 
# run the container
exec podman run -it --userns=keep-id \
    --log-level=debug \
    --network=bridge \
    --dns-opt single-request-reopen --dns-opt no-aaaa \
    -v $WORKSPACE_DIR:/workspace \
    -e OPENROUTER_API_KEY \
    -e LLAMA_API_KEY_JON_WORKSTATION \
    $DOCKER_TAG
