DOCKER = docker
PYTHON = python
NAME = rstudio

GIT_VERSION := $(shell git describe --abbrev=7 --dirty --always --tags)

TAG = $(GIT_VERSION)

SERVER_PORT ?= 8888
PWD := $(shell pwd)
WORKDIR ?= "$(PWD)"
SERVER_VERSION ?= "latest"
USER := $(shell whoami)

server:
	$(DOCKER) run -d -p $(SERVER_PORT):8888 \
		-v $(WORKDIR):/home/jovyan/work \
		--name $(NAME)-$(USER) \
		$(NAME) \
		start-notebook.sh \
		--NotebookApp.token=''

stop_server:
		$(DOCKER) rm -f $(NAME)-$(USER)

docker:
		$(DOCKER) build -t $(NAME) .

build:
		 make docker
