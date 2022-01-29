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
#RUN go mod tidy

## Our project will now successfully build with the necessary go libraries included.
RUN go build -o news-demo.exe .

# The app is running on port 3000
EXPOSE 3000

## Our start command which kicks off
## our newly created binary executable
## Use what is known as EXEC form instead of SHELL form
## i.e. do not say RUN xyz...
CMD ["/app/news-demo.exe"]
####################
# SOME DOCUMENTATION
#
# HOORAY!
# This command below successfully builds an image
# named la1979/news-demo
# docker build -t la1979/news-demo .
#
# HOORAY - this command starts and runs the news-demo container
# BUT ... you still need to use localhost:3000
# docker run -dp 3000:3000 --name news-demo la1979/news-demo
#
# Do NOT say docker run -dp 3000:80 --name la1979/news-demo
# the --name causes an error message saying you need at least 1 argument!
#
# Next try:
# docker run -dp 3000:80 --name news-demo la1979/news-demo
# NOOOO.  Fails miserably.
# That is b/c the meaning is LOCAL:CONTAINER