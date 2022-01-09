# syntax=docker/dockerfile:1

FROM golang:1.15-alpine

WORKDIR /app

COPY go.sum ./

COPY go.mod ./
RUN go mod download
RUN go mod tidy

RUN apk add git

RUN go get github.com/joho/godotenv
RUN go get github.com/Freshman-tech/news-demo/news

COPY *.go ./
RUN go build -o /docker-news-app

EXPOSE 3000

CMD [ "/docker-news-app" ]
