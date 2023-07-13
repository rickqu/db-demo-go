FROM golang:1.20.5-alpine3.17

WORKDIR /app
COPY . /app/

RUN go mod download

CMD go test
