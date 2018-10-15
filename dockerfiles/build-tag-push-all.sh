#!/usr/bin/env bash

### USAGE ###
#
#   Builds docker images for WSO2 Stream-processor components
#
#   --- Usage: ./build-tag-push.sh version registry
#
#   -- Example usage: ./build-tag-push.sh 4.3.0 docker.sqooba.io/sqooba/

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
registry=${2:-""}
version=$1

echo "Building docker components for Stream processor version: $version"

pushd $DIR/base
    docker build -t ${registry}wso2sp-base:$version --build-arg WSO2_SERVER_VERSION=$version .
    docker push ${registry}wso2sp-base:$version
popd

pushd $DIR/dashboard
    docker build -t ${registry}wso2sp-dashboard:$version --build-arg WSO2_SERVER_VERSION=$version .
    docker push ${registry}wso2sp-dashboard:$version
popd

pushd $DIR/editor
    docker build -t ${registry}wso2sp-editor:$version --build-arg WSO2_SERVER_VERSION=$version .
    docker push ${registry}wso2sp-editor:$version
popd

pushd $DIR/manager
    docker build -f $DIR/manager/Dockerfile -t ${registry}wso2sp-manager:$version --build-arg WSO2_SERVER_VERSION=$version .
    docker push ${registry}wso2sp-manager:$version
popd

pushd $DIR/worker/
    docker build -f $DIR/worker/Dockerfile -t ${registry}wso2sp-worker:$version --build-arg WSO2_SERVER_VERSION=$version .
    docker push ${registry}wso2sp-worker:$version
popd

echo "Finished building base, dashboard, editor, manager, worker"