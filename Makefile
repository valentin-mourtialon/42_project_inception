SRCS = ./srcs/docker-compose.yml

all: 
	mkdir -p /home/vmourtia/data/mariadb
	mkdir -p /home/vmourtia/data/wordpress
	${MAKE} -s build
	${MAKE} -s run 

build:
	docker-compose -f ${SRCS} build

run:
	docker-compose -f ${SRCS} up -d

down:
	docker-compose -f ${SRCS} down

clean: down
	sudo rm -rf /home/vmourtia/data/mariadb
	sudo rm -rf /home/vmourtia/data/wordpress

fclean:
	${MAKE} -s clean
	docker system prune -f -a --volumes
	# Check if 'wordpress' exists
	@if docker volume ls | grep -q 'wordpress'; then \
		docker volume rm wordpress; \
	fi
	# Check if 'mariadb' exists
	@if docker volume ls | grep -q 'mariadb'; then \
		docker volume rm mariadb; \
	fi

re: fclean
	${MAKE} -s all

.PHONY: all build run down clean fclean re
