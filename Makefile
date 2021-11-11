PROJECT_NAME ?= cicd
SHELL 	 := /bin/bash
executable := cicd

all: fmt test $(executable)

clean:
	@rm -rf bin/*

$(executable):
	@echo Building $(executable)
	go build -o bin/$@ cmd/$@/main.go

build:
	@echo Building $(executable)
	GOOS=linux go build -o bin/$(executable) cmd/$(executable)/main.go
	docker build -t edchristiand/test-cicd -f Dockerfile .

fmt:
	find . -name '*.go' | grep -v vendor | xargs gofmt -w -s

test:
	go test ./...

.PHONY: clean $(executable) build fmt test
