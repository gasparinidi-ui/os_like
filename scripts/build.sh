#!/bin/sh
# Gera a ISO do OSLike usando Docker. Uso: ./scripts/build.sh
set -e
cd "$(dirname "$0")/.."

docker build -t oslike-builder .
docker run --rm --privileged -v "$PWD":/build -v oslike-work:/work oslike-builder
