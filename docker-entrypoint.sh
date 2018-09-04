#!/bin/sh
set -e

set -x

go get -d -v "$GOLANG_PACKAGE/..."
cd "/go/src/$GOLANG_PACKAGE" && \
  git fetch -q origin && \
  git checkout -q --force "$GOLANG_PACKAGE_SHA1"
go install -v "$GOLANG_PACKAGE/..."

"$@"
