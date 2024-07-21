# Variables
APP_NAME := sketelon
BUILD_DIR := build
DOCKER_IMAGE := sketelon
GO_FILES := $(shell find . -type f -name '*.go' -not -path "./vendor/*")
GO_MAIN := main.go

# Build the Go binary
build: $(GO_FILES)
	@echo "Building the Go binary..."
	@mkdir -p $(BUILD_DIR)
	@go build -o $(BUILD_DIR)/$(APP_NAME) $(GO_MAIN)
	@echo "Build complete: $(BUILD_DIR)/$(APP_NAME)"

# Run the Go application
run: build
	@echo "Running the application..."
	@./$(BUILD_DIR)/$(APP_NAME)

# Clean the build directory
clean:
	@echo "Cleaning up..."
	@rm -rf $(BUILD_DIR)
	@echo "Clean complete."

# Run tests
test:
	@echo "Running tests..."
	@go test ./...
	@echo "Tests complete."

# Build the Docker image
docker-build:
	@echo "Building the Docker image..."
	@docker build -t $(DOCKER_IMAGE) .
	@echo "Docker image build complete: $(DOCKER_IMAGE)"

# Remove the Docker image
docker-clean:
	@echo "Removing the Docker image..."
	@docker rmi $(DOCKER_IMAGE)
	@echo "Docker image removed: $(DOCKER_IMAGE)"

# Help
help:
	@echo "Makefile for Go application"
	@echo "Usage:"
	@echo "  make build        Build the Go binary"
	@echo "  make run          Run the Go application"
	@echo "  make clean        Clean the build directory"
	@echo "  make test         Run tests"
	@echo "  make docker-build Build the Docker image"
	@echo "  make docker-clean Remove the Docker image"
	@echo "  make help         Show this help message"

.PHONY: build run clean test docker-build docker-clean help