#!/bin/sh
set -e

if [ -z "$GOLANG_PACKAGE" ]; then
  echo "fatal: missing GOLANG_PACKAGE environment variable" > /dev/stderr
  exit 1
fi

if [ -z "$GOLANG_PACKAGE_SHA1" ]; then
  echo "fatal: missing GOLANG_PACKAGE_SHA1 environment variable" > /dev/stderr
  exit 1
fi

if [ $# -eq 0 ]; then
  echo "fatal: please pass a command to execute" > /dev/stderr
  exit 1
fi


set -x

go get -d -v "$GOLANG_PACKAGE/..."
cd "/go/src/$GOLANG_PACKAGE" && \
  git fetch -q origin && \
  git checkout -q --force "$GOLANG_PACKAGE_SHA1"
go install -v "$GOLANG_PACKAGE/..."

"$@"
