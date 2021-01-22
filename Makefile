.PHONY: all
all:
	docker build . -t rise_artifact

run:
	docker run -it rise_artifact


.PHONY: all
