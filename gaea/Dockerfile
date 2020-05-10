FROM golang:latest

LABEL cyf <1627999813@qq.com>

COPY Gaea-1.0.0 /go/gaea
RUN bash -c 'make build'

EXPOSE 13306

WORKDIR /go/gaea

ENTRYPOINT ["/go/gaea/bin/gaea"]
