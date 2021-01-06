.PHONY: all
all:
	git submodule update --init
	docker build . -t rise_artifact

run:
	docker run -it rise_artifact


.PHONY: all
