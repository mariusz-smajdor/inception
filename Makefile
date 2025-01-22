DOCKER_COMPOSE = docker-compose -f ./srcs/docker-compose.yml
DATA_DIR = $(HOME)/data

# Start the Docker containers
all:
	@mkdir -p $(DATA_DIR)/wordpress
	@mkdir -p $(DATA_DIR)/mariadb
	@$(DOCKER_COMPOSE) up -d

# Stop and remove containers, networks, and optionally anonymous volumes
down:
	@$(DOCKER_COMPOSE) down

# Stop all running containers in the docker-compose project
stop:
	@$(DOCKER_COMPOSE) stop

# Start all stopped containers in the docker-compose project
start:
	@$(DOCKER_COMPOSE) start

# Display the status of the containers in the docker-compose project
status:
	@$(DOCKER_COMPOSE) ps

# Rebuild and start the Docker containers
re:
	@$(DOCKER_COMPOSE) down
	@$(DOCKER_COMPOSE) up --build -d

# Stop running containers, remove all containers, Docker images, volumes, and networks
clean:
	@docker stop $$(docker ps -qa) 2>/dev/null || true; \
	docker rm $$(docker ps -qa) 2>/dev/null || true; \
	docker rmi -f $$(docker images -qa) 2>/dev/null || true; \
	docker volume rm $$(docker volume ls -q) 2>/dev/null || true; \
	docker network rm $$(docker network ls -q) 2>/dev/null || true; \
	rm -rf $(DATA_DIR)/wordpress; \
	rm -rf $(DATA_DIR)/mariadb

fclean: down clean

.PHONY: all down stop start status re clean fclean
