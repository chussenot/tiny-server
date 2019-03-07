IMAGE=chussenot/tiny-server
VERSION=0.1

build:
	CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main .

package:
	docker build -t ${IMAGE} -f Dockerfile.scratch .

run: build package
	docker run -it -p 1323:80 ${IMAGE}

install:
	go get -u github.com/labstack/echo

test:
	http://localhost:1323/health-check

push:
	docker push ${IMAGE}
	docker tag ${IMAGE} ${IMAGE}:${VERSION}
	docker push ${IMAGE}:${VERSION}
