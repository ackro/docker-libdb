#!/bin/bash
set -e

REPOSITORY="ackro"
PACKAGE="libdb"
PACKAGE_SUFFIX="-alpine"

function docker_build {
  TAG=${1}
  ADDITIONAL_TAG=""

  if [ -z "${2}" ]; then
    BUILD=""
    ADDITIONAL_TAG=" -t$REPOSITORY/$PACKAGE:latest"
  else
    BUILD="-${2}"
  fi

  eval "docker build -t${REPOSITORY}/${PACKAGE}:${TAG}${BUILD}${PACKAGE_SUFFIX} ${ADDITIONAL_TAG} ."
}

for tag in *; do
  if [ -d "${tag}" ]; then
    (
      cd "${tag}"
      for build in *; do
        if [ -d "${build}" ]; then
          if [ -f "${build}/Dockerfile" ]; then
            (
              cd "${build}"
              docker_build "${tag}" "${build}"
            )
          fi
        fi
      done
      if [ -f Dockerfile ]; then
        docker_build ${tag}
      fi
    )
  fi
done
