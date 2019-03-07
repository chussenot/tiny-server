#!/usr/bin/env bash

if [ "$TRAVIS_GO_VERSION" = "1.11.5" ] \
    && [ "$TRAVIS_BRANCH" = "master" ] \
    && [ -n "$TRAVIS_TAG" ]; then

    docker build -t chussenot/tiny-server:$TRAVIS_TAG \
			-t chussenot/tiny-server:latest \
			-f Dockerfile.scratch .
fi
