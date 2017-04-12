
build:
	CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main .
	docker build -t tiny-server -f Dockerfile.scratch .

run: build
	docker run -it -p 1323:80 tiny-server

install:
	go get -u github.com/labstack/echo

test:
	http://localhost:1323/health-check
