#/bin/bash -xe

DOCKER_TAG=emlearn-micropython-dev
WORKSPACE_DIR=/home/jon/projects/emlearn-micropython

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [[ -z "${OPENROUTER_API_KEY}" ]]; then
  echo "Error: OPENROUTER_API_KEY is not set" >&2
  exit 1
fi

# rebuild docker image (if needed)
cd $DIR
cp $WORKSPACE_DIR/requirements*.txt ./
docker build . -t $DOCKER_TAG

# run the container
exec docker run -it -u $(id -u):$(id -g) -v $WORKSPACE_DIR:/workspace -e OPENROUTER_API_KEY $DOCKER_TAG
