#!/usr/bin/env bash

### USAGE ###
#
#   Builds docker images for WSO2 Stream-processor components
#
#   --- Usage: ./tag-push-all.sh version registry
#
#   -- Example usage: ./tag-push-all.sh 4.3.0 docker.sqooba.io/sqooba/

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
registry=${2:-""}
version=$1

echo "Building docker components for Stream processor version: $version"

pushd $DIR/base
    docker tag wso2sp-base:$version ${registry}wso2sp-base:$version
    docker push ${registry}wso2sp-base:$version
popd

pushd $DIR/dashboard
    docker tag wso2sp-dashboard:$version ${registry}wso2sp-dashboard:$version
    docker push ${registry}wso2sp-dashboard:$version
popd

pushd $DIR/editor
    docker tag wso2sp-editor:$version ${registry}wso2sp-editor:$version
    docker push ${registry}wso2sp-editor:$version
popd

pushd $DIR/manager
    docker tag wso2sp-manager:$version ${registry}wso2sp-manager:$version
    docker push ${registry}wso2sp-manager:$version
popd

pushd $DIR/worker/
    docker tag wso2sp-worker:$version ${registry}wso2sp-worker:$version
    docker push ${registry}wso2sp-worker:$version
popd

pushd $DIR/worker-extended/
    version_ext=${version}_extended
    docker tag wso2sp-worker:${version_ext} ${registry}wso2sp-worker:${version_ext}
    docker push ${registry}wso2sp-worker:${version_ext}
popd

echo "Finished building base, dashboard, editor, manager, worker"