FROM golang:1.20 as builder
WORKDIR /workspace
COPY ./ .
RUN go mod download
RUN CGO_ENABLED=0 go build -o ./v2ray -trimpath -ldflags "-s -w -buildid=" ./main

FROM ubuntu:22.04
WORKDIR /
COPY --from=builder /workspace/v2ray .
ENTRYPOINT ["/v2ray"]
