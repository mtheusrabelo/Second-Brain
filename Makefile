DB_CONTAINER_NAME=second-brain-db
CONTAINER_NAME=second-brain
PWD=$(shell pwd)
APPDIR=/app
PORT=1337

build-dev:
	docker build . -t $(CONTAINER_NAME):latest --target development

run-dev:
	docker run --rm -it \
		-e PORT=$(PORT) \
		-v $(PWD):$(APPDIR):delegated \
		--network="host" --name $(CONTAINER_NAME) $(CONTAINER_NAME)

exec-dev:
	docker exec -it $(CONTAINER_NAME) bash

build-prod:
	docker build . -t $(CONTAINER_NAME):latest --target production

run-local-db:
	docker run --rm -d \
		-p $(SECOND_BRAIN_DB_PORT):5432 \
		-e POSTGRES_USER=$(SECOND_BRAIN_DB_USER) \
		-e POSTGRES_PASSWORD=$(SECOND_BRAIN_DB_PASSWORD) \
		-e POSTGRES_DB=$(SECOND_BRAIN_DB) \
		-v $(SECOND_BRAIN_DB_DATA_FOLDER):/var/lib/postgresql/data \
		--name $(DB_CONTAINER_NAME) postgres:13-alpine

stop-local-stop:
	docker stop $(DB_CONTAINER_NAME)
