#FROM registry.redhat.io/ubi8/go-toolset:1.16.7-5.1638364094 AS builder
FROM quay.io/fedora/fedora:35 AS builder
RUN dnf install -y golang
WORKDIR /foo
COPY http-client.go .
RUN go version && go build http-client.go 

FROM quay.io/fedora/fedora:35
ADD redhat.crt /etc/pki/ca-trust/source/anchors/artifacts.crt
ADD cicd.crt /etc/pki/tls/certs/artifacts.crt
RUN update-ca-trust extract
COPY --from=builder /foo/http-client /usr/bin
