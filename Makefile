SRCS = ./srcs/docker-compose.yml

all: 
	${MAKE} -s build
	${MAKE} -s run 

build:
	docker-compose -f ${SRCS} build

run:
	docker-compose -f ${SRCS} up -d

clean:
	docker-compose -f ${SRCS} down

.PHONY: all build clean
