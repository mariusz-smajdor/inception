DOCKER_COMPOSE = docker-compose -f ./srcs/docker-compose.yml
DATA_DIR = $(HOME)/data

# Start the Docker containers
all:
	@mkdir -p $(DATA_DIR)/wordpress
	@mkdir -p $(DATA_DIR)/mariadb
	@$(DOCKER_COMPOSE) up

# Stop and remove containers, networks, and optionally anonymous volumes
down:
	@$(DOCKER_COMPOSE) down

# Stop all running containers in the docker-compose project
stop:
	@$(DOCKER_COMPOSE) stop

# Start all stopped containers in the docker-compose project
start:
	@$(DOCKER_COMPOSE) start

# Display all running Docker containers
status:
	@docker ps

# Rebuild and start the Docker containers
re:
	@$(DOCKER_COMPOSE) up --build

# Stop running containers, remove all containers, Docker images, volumes and networks
clean:
	@docker stop $$(docker ps -qa); \
	docker rm $$(docker ps -qa); \
	docker rmi -f $$(docker images -qa); \
	docker volume rm $$(docker volume ls -q); \
	docker network rm $$(docker network ls -q); \
	rm -rf $(DATA_DIR)/wordpress; \
	rm -rf $(DATA_DIR)/mariadb

fclean: stop down clean

.PHONY: all down stop start status re clean