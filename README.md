Simple HTTP server in a tiny container
======================================

[![Docker chussenot/tiny-server Pulls](https://img.shields.io/docker/pulls/chussenot/tiny-server.svg?label=docker%20pulls%20chussenot/tiny-server)](https://hub.docker.com/r/chussenot/tiny-server/)
[![Build Status](https://www.travis-ci.org/chussenot/tiny-server.svg?branch=master)](https://www.travis-ci.org/chussenot/tiny-server)

[![License](https://img.shields.io/badge/License-BSD%202--Clause-orange.svg)](https://opensource.org/licenses/BSD-2-Clause)

Why?
---

Microservices-based applications often use heartbeats or health checks
to enable their performance monitors, schedulers, and orchestrators
to keep track of the multitude of services.

If services cannot send some sort of “I’m alive” signal, either on demand
or on a schedule, your application might face risks when you deploy updates,
or it might just detect failures too late and not be able to stop cascading
failures that can end up in major outages.

How?
----

This server use Echo,
the High performance, extensible, minimalist Go web framework
https://echo.labstack.com/guide

Distribution
------------

You can compile directly the server with **Go**:

`go build -o main`

But the server is as well release in a docker image.

`docker pull chussenot/tiny-server`

The idea is to build a minimal docker container (6.75 MB) for this go application,
that always return 200 HTTP codes to help you to build your healthchecks
ib your orchestrator solutions.
```
# chussenot @ laptop in ~ [0:02:03]
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
to Linux (in case someone builds this on a Mac or Windows or BSDs) and the -a flag
means to rebuild all the packages we’re using, which means all the imports will
be rebuilt with cgo disabled.

Now we have a static binary with only 6.75MB

To build and test just run `make install` then `make run`
and `curl http://localhost:80` in an another shell.

Travis
------

The Travis CI service build and release the image on the Docker hub.

Contributing
------------

1. Fork it (<https://github.com/chussenot/tiny-server/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

Contributors
------------

- [Clement Hussenot](https://github.com/chussenot) - creator and maintainer
