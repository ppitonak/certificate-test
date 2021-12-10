FROM registry.redhat.io/ubi8/go-toolset AS builder
WORKDIR /go
COPY http-client.go .
RUN go build http-client.go 

FROM quay.io/fedora/fedora:35
ADD artifacts.crt /etc/pki/ca-trust/source/anchors/artifacts.crt
RUN update-ca-trust extract
COPY --from=builder /go/http-client /usr/bin
