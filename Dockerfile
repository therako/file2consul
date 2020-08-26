FROM golang:1.15.0-alpine3.12 AS build

LABEL app="file2consul"

ADD . /go/src/github.com/therako/file2consul
WORKDIR /go/src/github.com/therako/file2consul

RUN go build -ldflags '-extldflags "-static"' -tags 'static_build' ./src/file2consul.go

FROM alpine:3.12
WORKDIR /usr/bin
COPY --from=build /go/src/github.com/therako/file2consul/file2consul .
ENTRYPOINT [ "file2consul" ]
