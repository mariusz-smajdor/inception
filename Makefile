DOCKER_COMPOSE = docker-compose -f ./srcs/docker-compose.yml
DATA_DIR = $(HOME)/data

# Start the Docker containers and create necessary directories
all: init_dirs
	@$(DOCKER_COMPOSE) up -d

# Initialize required directories
init_dirs:
	@mkdir -p $(DATA_DIR)/wordpress
	@mkdir -p $(DATA_DIR)/mariadb

# Stop and remove containers, networks, and optionally anonymous volumes
down:
	@$(DOCKER_COMPOSE) down --volumes --remove-orphans

# Stop all running containers in the Docker Compose project
stop:
	@$(DOCKER_COMPOSE) stop

# Start previously stopped containers in the Docker Compose project
start:
	@$(DOCKER_COMPOSE) start

# Display the status of all running Docker containers
status:
	@$(DOCKER_COMPOSE) ps

# Rebuild and start the Docker containers
re: clean all

# Stop all containers, remove them, and clean up related resources
clean:
	@docker stop $$(docker ps -qa) 2>/dev/null || true; \
	docker rm $$(docker ps -qa) 2>/dev/null || true; \
	docker rmi -f $$(docker images -qa) 2>/dev/null || true; \
	docker volume rm $$(docker volume ls -q) 2>/dev/null || true; \
	docker network prune -f; \
	rm -rf $(DATA_DIR)/wordpress; \
	rm -rf $(DATA_DIR)/mariadb

# Full cleanup, including stopping and removing all containers and networks
fclean: down clean

# Add a phony directive to avoid conflicts with files of the same name
.PHONY: all init_dirs down stop start status re clean fclean
