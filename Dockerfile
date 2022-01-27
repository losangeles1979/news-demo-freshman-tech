# syntax=docker/dockerfile:1

# I based this Dockerfile on information from this website:
# https://docker.github.io/get-involved/docs/communityleaders/eventhandbooks/go/gomodules 
# January 26, 2022

FROM golang:1.15-alpine

RUN mkdir /app

ADD . /app

WORKDIR /app

# I think git is part of the base image above
# RUN apk add git

## Add this go mod download command to pull in any dependencies
RUN go mod download
#RUN go mod download
#RUN go mod tidy

## Our project will now successfully build with the necessary go libraries included.
RUN go build -o news-demo.exe .

# The app is running on port 3000
EXPOSE 3000

## Our start command which kicks off
## our newly created binary executable
CMD ["/app/news-demo.exe"]
