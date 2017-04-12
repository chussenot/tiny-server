Simple HTTP server in a tiny container
======================================

[TinyServer on Docker Hub](https://hub.docker.com/r/chussenot/tiny-server/)

This exemple use Echo,
the High performance, extensible, minimalist Go web framework
https://echo.labstack.com/guide

The idea is to build a minimal docker container for this go application

```
# chussenot @ macbook-air in ~ [0:02:03]
$ docker images | head
REPOSITORY
TAG              IMAGE ID            CREATED             SIZE
tiny-server
latest              fa2d76fd1543        3 days ago          6.75 MB
```

Ok so we will build a very ligth weight docker image!

How to do this ? Just start from SCRATCH!
Scratch is a special docker image that’s empty. It’s truly 0B.
But our Go binary is looking for libraries on the operating system
it’s running in.

```
CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main .
```

We’re disabling cgo which gives us a static binary. We’re also setting the OS
to Linux (in case someone builds this on a Mac or Windows) and the -a flag
means to rebuild all the packages we’re using, which means all the imports will
be rebuilt with cgo disabled.

Now we have a static binary with only 6.75MB

To build and test just run `make install` then `make run`
and `curl http://localhost:80` in an another shell.
