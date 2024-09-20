.PHONY=build
# include .env
# export $(shell sed 's/=.*//' .env)
build:
	@CGO_ENABLED=0 GOOS=linux go build -o bin/joke-app cmd/main.go

run: build
	@./bin/joke-app

coverage:
	@go test -v -cover ./...

test:
	@go test -v ./...
