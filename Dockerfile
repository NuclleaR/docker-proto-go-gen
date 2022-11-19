ARG GO_VERSION

FROM golang:$GO_VERSION

# Base libraries
RUN apt-get update
RUN apt-get install -y protobuf-compiler

ARG PROTOC_GEN_GO
ARG PROTOC_GEN_GO_GRPC
ARG PROTOC_GEN_VALIDATE

# Go proto dependencies
RUN go install google.golang.org/protobuf/cmd/protoc-gen-go@v$PROTOC_GEN_GO
RUN go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@v$PROTOC_GEN_GO_GRPC
RUN go install github.com/envoyproxy/protoc-gen-validate@v$PROTOC_GEN_VALIDATE

# Common base proto dependencies.
RUN git clone https://github.com/googleapis/googleapis

RUN mkdir -p /go/proto-common/validate
RUN cp pkg/mod/github.com/envoyproxy/protoc-gen-validate@v$PROTOC_GEN_VALIDATE/validate/validate.proto /go/proto-common/validate/validate.proto
RUN cp -r googleapis/google /go/proto-common
