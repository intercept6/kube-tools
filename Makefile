NAME=kmd2kmd/kube-tools
VERSION=1.12.7-1

running_container_id=`docker ps -q -f ancestor=${NAME}:${VERSION}`
all_container_id=`docker ps -aq -f ancestor=${NAME}:${VERSION}`
image_id=`docker images -q ${NAME}`

.PHONY: build
build:
	@docker build -t ${NAME}:${VERSION} .

.PHONY: restart
restart: stop start

.PHONY: start
start:
	docker run -it ${NAME}:${VERSION} \
	sh

stop:
	@if [ "$(running_container_id)" != "" ] ; then \
        docker stop $(running_container_id); \
    fi

.PHONY: images
images:
	@docker images ${NAME}

.PHONY: clean
clean: stop
	@if [ "$(all_container_id)" != "" ] ; then \
        docker rm $(all_container_id); \
    fi
	@if [ "$(image_id)" != "" ] ; then \
        docker rmi $(image_id); \
    fi

# .PHONY: circleci-validate
# circleci-validate:
# 	@circleci config validate

# .PHONY: circleci-local
# circleci-local:
# 	@circleci config process .circleci/config.yml > .circleci/config-2.0.yml 
# 	@circleci local execute -c .circleci/config-2.0.yml --job build-version