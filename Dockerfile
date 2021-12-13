#FROM registry.redhat.io/ubi8/go-toolset:1.16.7-5.1638364094 AS builder
FROM quay.io/fedora/fedora:35 AS builder
RUN dnf install -y golang
WORKDIR /foo
COPY http-client.go .
RUN go version && go build http-client.go 

FROM quay.io/fedora/fedora:35
ADD redhat.crt /etc/pki/ca-trust/source/anchors/redhat.crt
#ADD redhat.crt /etc/pki/tls/certs/redhat.crt

#ADD gitlab.crt /etc/pki/tls/certs/gitlab.crt

ADD cicd.crt /etc/pki/tls/certs/cicd.crt
#ADD cicd.crt /etc/pki/ca-trust/source/anchors/cicd.crt
RUN update-ca-trust extract
COPY --from=builder /foo/http-client /usr/bin
