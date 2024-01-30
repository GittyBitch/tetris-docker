# Makefile

# Variables
IMAGE_NAME := docker-tetris
TAG := latest
PORT_HOST := 8080
PORT_CONTAINER := 80
DETACHED := -d
DOCKER_USERNAME := chubbyface
REPO_NAME := $(DOCKER_USERNAME)/$(IMAGE_NAME)

.PHONY: build run all

# Build the Docker image
build:
	docker build -t $(IMAGE_NAME):$(TAG) .

# Run the Docker container
run: build
	docker run $(DETACHED) -p $(PORT_HOST):$(PORT_CONTAINER) $(IMAGE_NAME):$(TAG)
	docker tag $(IMAGE_NAME):$(TAG) $(REPO_NAME):$(TAG)

login: 
	@echo "Logging in to Docker Hub"
	@docker login -u $(DOCKER_USERNAME) 

# Push the Docker image to Docker Hub
push: build login
	docker push $(REPO_NAME):$(TAG)

# deploy: push

# Build and run
all: run

