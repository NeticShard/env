SOURCE_FILES?=./...
TEST_PATTERN?=.

export GO111MODULE := on

setup:
	go mod tidy
.PHONY: setup

build:
	go build
.PHONY: build

test:
	go test -v -failfast -race -coverpkg=./... -covermode=atomic -coverprofile=coverage.txt $(SOURCE_FILES) -run $(TEST_PATTERN) -timeout=2m
.PHONY: test

cover: test
	go tool cover -html=coverage.txt
.PHONY: cover

fmt:
	gofumpt -w -l .
.PHONY: fmt

lint:
	golangci-lint run ./...
.PHONY: lint

ci: build test
.PHONY: ci

.DEFAULT_GOAL := ci
