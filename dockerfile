# a service container example with go
# Use an official Golang runtime as a base image
FROM --platform=linux/amd64 golang:alpine AS builder

# Set the working directory inside the container
WORKDIR /app

# Copy the local code to the container
COPY . .

# Download and install any required dependencies
# you can only use it when you have go.mod and go.sum in image directory
RUN go get -d -v ./...

# Install or build your Go application
# RUN GOOS=linux GOARCH=amd64 go install -v ./...
RUN GOOS=linux GOARCH=amd64 go build -o kube .

# Create a minimal final image
# build new image from previous
FROM --platform=linux/amd64 alpine:latest
# FROM --platform=linux/amd64 scratch

# Copy only the necessary files from the builder image
COPY --from=builder /app/kube ./bin/sh

WORKDIR /app

# Expose the port your application listens on 
EXPOSE 8080

# Set the entry point for the container
CMD kube

LABEL maintainer="elnur.shamiyev@gmail.com"
LABEL author="elnur.shamiyev@gmail.com"
