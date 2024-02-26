FROM golang:latest as build
WORKDIR /app

FROM base AS builder
WORKDIR /app
COPY . /app
RUN go mod download \
    && go mod verify
RUN make build-app

FROM alpine:latest
RUN apk update \
    && apk add --no-cache \
    ca-certificates \
    curl \
    tzdata \
    && update-ca-certificates

COPY --from=builder /app/dist/app /usr/local/bin/app
EXPOSE 8080
ENTRYPOINT ["/usr/local/bin/app"]
