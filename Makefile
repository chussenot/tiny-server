
build:
	CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main .
	docker build -t tiny-server -f Dockerfile.scratch .
run: build
	docker run -it -p 1323:1323 tiny-server
install:
	go get -u github.com/labstack/echo
