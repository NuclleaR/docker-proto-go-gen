PROTO_DIR=./proto
PROTO_FILES=$(wildcard $(PROTO_DIR)/*.proto)
# PROTO_GET_OUTPUT=./gen
PLATFORM = $(shell uname -m)

.PHONY: protoc
protoc: # Generate protobuf files
	docker-compose run --rm protoc

.PHONY: install-validator
install-validator: # Install protoc-gen-validate
	@if [ -z $(VALIDATOR_VERSION) ]; then\
		echo "VALIDATOR_VERSION is not set";\
		exit 1;\
  fi
	@echo "Installing protoc-gen-validate v$(VALIDATOR_VERSION)"
	@go get github.com/envoyproxy/protoc-gen-validate
	@go install github.com/envoyproxy/protoc-gen-validate
	@mkdir -p ./proto/validate
	@cp $(GOPATH)/pkg/mod/github.com/envoyproxy/protoc-gen-validate@v$(VALIDATOR_VERSION)/validate/validate.proto ./proto/validate/validate.proto
	@echo "Done"
