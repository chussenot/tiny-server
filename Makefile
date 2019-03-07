IMAGE=chussenot/tiny-server
TRAVIS_TAG:=0.1

build:
	CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main .

package:
	docker build -t ${IMAGE} -f Dockerfile.scratch .

run: build package
	docker run -it -p 1323:80 ${IMAGE}

install:
	go get -u github.com/labstack/echo

test: install
	go test -v ./...

push:
	docker push ${IMAGE}
	docker tag ${IMAGE} ${IMAGE}:${TRAVIS_TAG}
	docker push ${IMAGE}:${TRAVIS_TAG}
