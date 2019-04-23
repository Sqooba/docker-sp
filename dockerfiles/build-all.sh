#!/usr/bin/env bash

### USAGE ###
#
#   Builds docker images for WSO2 Stream-processor components
#
#   --- Usage: ./build-tag-all.sh version
#
#   -- Example usage: ./build-tag-all.sh 4.3.0

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
version=$1

echo "Building docker components for Stream processor version: $version"

pushd $DIR/base
    docker build -t wso2sp-base:$version --build-arg WSO2_SERVER_VERSION=$version .
popd

pushd $DIR/dashboard
    docker build -t wso2sp-dashboard:$version --build-arg WSO2_SERVER_VERSION=$version .
popd

pushd $DIR/editor
    docker build -t wso2sp-editor:$version --build-arg WSO2_SERVER_VERSION=$version .
popd

pushd $DIR/manager
    docker build -f $DIR/manager/Dockerfile -t wso2sp-manager:$version --build-arg WSO2_SERVER_VERSION=$version .
popd

pushd $DIR/worker/
    docker build -f $DIR/worker/Dockerfile -t wso2sp-worker:$version --build-arg WSO2_SERVER_VERSION=$version .
popd

pushd $DIR/worker-extended/
    version_ext=${version}_extended
    docker build -f $DIR/worker-extended/Dockerfile -t wso2sp-worker:${version_ext} --build-arg WSO2_SERVER_VERSION=$version .
popd

echo "Finished building base, dashboard, editor, manager, worker"