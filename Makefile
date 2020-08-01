DB_CONTAINER_NAME=second-brain-db
CONTAINER_NAME=second-brain
PWD=$(shell pwd)
APPDIR=/app
PORT=1337
CURRENT_TIMESTAMP=$(shell date +%Y%m%d%H%M%S)
MUID=$(shell id -u)
MGID=$(shell id -g)

build-dev:
	docker build . -t $(CONTAINER_NAME):latest \
	--build-arg	MUID=$(MUID) --build-arg MGID=$(MGID) --target development

run-dev:
	docker run --rm -it \
		-e PORT=$(PORT) \
		-v $(PWD):$(APPDIR):delegated \
		--network="host" --name $(CONTAINER_NAME) $(CONTAINER_NAME)

exec-dev:
	docker exec -it $(CONTAINER_NAME) bash

stop-dev:
	docker stop $(CONTAINER_NAME)

build-prod:
	docker build . -t $(CONTAINER_NAME):latest --target production

build-dev-db:
	docker build . -f $(PWD)/DB.Dockerfile \
	--build-arg	MUID=$(MUID) --build-arg MGID=$(MGID) \
	-t $(DB_CONTAINER_NAME):latest --target development

run-dev-db:
	docker run --rm -d \
		-p $(SECOND_BRAIN_DB_PORT):5432 \
		-e POSTGRES_USER=$(SECOND_BRAIN_DB_USER) \
		-e POSTGRES_PASSWORD=$(SECOND_BRAIN_DB_PASSWORD) \
		-e POSTGRES_DB=$(SECOND_BRAIN_DB) \
		-v $(SECOND_BRAIN_DB_DATA_FOLDER):/var/lib/postgresql/data \
		-v $(SECOND_BRAIN_BACKUP_FOLDER):/backups \
		--name $(DB_CONTAINER_NAME) $(DB_CONTAINER_NAME)

stop-dev-db:
	docker stop $(DB_CONTAINER_NAME)

backup:
	mkdir -p $(SECOND_BRAIN_BACKUP_FOLDER)/$(CURRENT_TIMESTAMP)/public/uploads
	cp -r public/uploads backups/$(CURRENT_TIMESTAMP)/public/uploads
	docker exec -it \
		-e CURRENT_TIMESTAMP=$(CURRENT_TIMESTAMP) \
		$(DB_CONTAINER_NAME) bash DB.backup.sh
