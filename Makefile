BUILD_DIR		  = dist
BUILD_USER       ?= $(shell whoami)@$(shell hostname)
BUILD_DATE       ?= $(shell date -u +"%Y-%m-%dT%H:%M:%SZ")
BUILD_DATE_SHORT ?= $(shell date -u +"%Y%m%d")

GIT_VERSION ?= $(shell git describe --tags --always --dirty)

help: # Print help on Makefile
	@grep '^[^.#]\+:\s\+.*#' Makefile | \
	sed "s/\(.\+\):\s*\(.*\) #\s*\(.*\)/\1: \3 [\2]/" | \
	expand -t20

clean:
	@echo "$$MSGCLEAN"
	@rm -rf $(BUILD_DIR)/
	go clean -testcache

fmt: # Format Go source code
	go fmt ./...

test: clean # Run unit tests
	@echo "$$MSGTEST"
	go test -cover ./...

build-app: clean # Build the application
	@echo "$$MSGBUILD"
	@mkdir -p $(BUILD_DIR)
	go build -ldflags "-s -f" -o $(BUILD_DIR)/app .

build-debug-app: clean # Build the application ready for debugging
	@echo "$$MSGBUILD"
	@mkdir -p $(BUILD_DIR)
	CGO_ENABLED=0 go install github.com/go-delve/delve/cmd/dlv@latest
	CGO_ENABLED=0 go build -gcflags "all=-N -l" -o $(BUILD_DIR)/app .

define MSGCLEAN
 Cleaning...
endef
export MSGCLEAN

define MSGTEST
 Testing...
endef
export MSGTEST

define MSGBUILD
 Building...
endef
export MSGBUILD