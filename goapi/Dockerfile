# Setup node exporter
FROM mwendler/wget:latest
WORKDIR /tmp

ARG NODE_EXPORTER_VERSION
RUN wget --no-check-certificate https://github.com/prometheus/node_exporter/releases/download/v${NODE_EXPORTER_VERSION}/node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64.tar.gz
RUN tar xvfz node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64.tar.gz

# Actual image
FROM golang:1.20.5-alpine3.17

ARG NODE_EXPORTER_VERSION
COPY --from=0 /tmp/node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64/* /node-exporter/

WORKDIR /app
COPY . /app/

RUN go mod download
RUN go build -o api api.go
RUN chmod 777 api
CMD /node-exporter/node_exporter & ./api

EXPOSE 19229/tcp
