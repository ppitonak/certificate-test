FROM quay.io/fedora/fedora:35

ADD artifacts.crt /etc/pki/ca-trust/source/anchors/artifacts.crt

RUN update-ca-trust extract
