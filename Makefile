#

RM=/bin/rm
FIND=/usr/bin/find
DOCKER=/usr/bin/docker
NAME=docker-behave
DOCKER_ID=donaldm314

CRUFT := $(shell $(FIND) . -type f -name "*~")

image:
	$(DOCKER) image build . --tag $(NAME)

clean:
	$(RM) -f $(CRUFT)

run: image
	$(DOCKER) run -d --name $(NAME) $(NAME)

running:
	$(DOCKER) ps --filter "name=$(NAME)"

stopped:
	$(DOCKER) ps -a --filter "name=$(NAME)"

stop:
	-$(DOCKER) stop $(shell $(DOCKER) ps -q -a --filter "name=$(NAME)")

push:
	$(DOCKER) tag $(NAME) $(DOCKER_ID)/$(NAME)
	$(DOCKER) push $(DOCKER_ID)/$(NAME)

rm: stop
	-$(DOCKER) rm $(shell $(DOCKER) ps -qa --filter "name=$(NAME)")

.PHONY: image clean run running stopped stop rm
