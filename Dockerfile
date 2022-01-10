# syntax=docker/dockerfile:1

FROM golang:1.15-alpine

WORKDIR /app

COPY go.sum ./

COPY go.mod ./
RUN go mod download
RUN go mod tidy

RUN apk add git

RUN go get github.com/joho/godotenv

COPY *.go ./

# Download all the dependencies
RUN go get -d -v ./...

# Avoid: RUN go build -o docker-news-app
# Install the package
RUN go install -v ./...

EXPOSE 3000

CMD [ "/main.exe" ]
