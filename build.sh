#!/usr/bin/env bash

set -ex

# Pack
python3 -m pip install -r requirements.txt --target packed
# cp main file and other deps, but in this case, only main file
cp -av server.py packed/__main__.py
python3 -m zipapp -p python3 packed --compress
mv packed.pyz server
rm packed -rf

if [ "$1" == "--container-test" ]; then
    # Run container with just Python3
    engine=$(which podman 2>/dev/null || which docker 2>/dev/null)
    $engine run --rm \
        -p 8000:8000 \
        -v $(pwd)/server:/server \
        --entrypoint=python3 \
        docker.io/library/python:3 /server
fi
