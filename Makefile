TARGETS = darwin/amd64 darwin/arm64 linux/amd64 linux/386 windows/amd64 windows/386
GIT_COMMIT = $(shell git rev-parse HEAD)
BUILD_TIME = $(shell date -u +"%Y-%m-%dT%H:%M:%SZ" | tr -d '\n')
GO_VERSION = $(shell go version | awk {'print $$3'})
DOCKER_RELEASE_TAG = "openGauss/openGauss-webclient:$(shell git describe --abbrev=0 --tags | sed 's/v//')"
DOCKER_LATEST_TAG = "openGauss/openGauss-webclient:latest"
LDFLAGS = -s -w
PKG = gitee.com/openGauss/openGauss-webclient

usage:
	@echo ""
	@echo "Task                 : Description"
	@echo "-----------------    : -------------------"
	@echo "make setup           : Install all necessary dependencies"
	@echo "make dev             : Generate development build"
	@echo "make build           : Generate production build for current OS"
	@echo "make release         : Generate binaries for all supported OSes"
	@echo "make test            : Execute test suite"
	@echo "make test-all        : Execute test suite on multiple PG versions"
	@echo "make clean           : Remove all build files and reset assets"
	@echo "make docker          : Build docker image"
	@echo "make docker-release  : Build and tag docker image"
	@echo "make docker-push     : Push docker images to registry"
	@echo ""

test:
	go test -race -cover ./pkg/...

test-all:
	@./script/test_all.sh
	@./script/test_cockroach.sh

dev:
	go build
	@echo "You can now execute ./openGauss-webclient"

build:
	go build
	@echo "You can now execute ./openGauss-webclient"

release: LDFLAGS += -X $(PKG)/pkg/command.GitCommit=$(GIT_COMMIT)
release: LDFLAGS += -X $(PKG)/pkg/command.BuildTime=$(BUILD_TIME)
release: LDFLAGS += -X $(PKG)/pkg/command.GoVersion=$(GO_VERSION)
release:
	@echo "Building amd64 binaries..."
	GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -ldflags "$(LDFLAGS)" -o "./bin/openGauss-webclient_linux_amd64"

	@echo "\nPackaging binaries...\n"
	@./script/package.sh

setup:
	go install github.com/mitchellh/gox@v1.0.1

clean:
	@rm -f ./openGauss-webclient*
	@rm -rf ./bin/*

docker:
	docker build --no-cache -t openGauss-webclient .

docker-release:
	docker build --no-cache -t $(DOCKER_RELEASE_TAG) .
	docker tag $(DOCKER_RELEASE_TAG) $(DOCKER_LATEST_TAG)
	docker images $(DOCKER_RELEASE_TAG)

docker-push:
	docker push $(DOCKER_RELEASE_TAG)
	docker push $(DOCKER_LATEST_TAG)
