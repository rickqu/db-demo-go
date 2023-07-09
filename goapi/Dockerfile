FROM golang:1.20.5-alpine3.17

WORKDIR /app
COPY . /app/

RUN go mod download
RUN go build -o api api.go
RUN chmod 777 api
#RUN rm api.go go.mod go.sum
CMD ./api

EXPOSE 19229/tcp
