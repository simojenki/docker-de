
VNC_PASSWORD ?= $(shell echo $RANDOM | md5sum | head -c 20; echo;)

PHONY := clean image run

clean:
	docker rmi --force simojenki/de:latest

image:
	docker build --pull -t simojenki/de:latest .

run: image
	@echo "VNC_PASSWORD=${VNC_PASSWORD}"

	docker run \
		-it \
		-p 127.0.0.1:5901:5901 \
		-e PUID=$(shell id -u) \
		-e PGID=$(shell id -g) \
		-e PNAME=$(shell whoami) \
		-e VNC_DISPLAY=1 \
		-e VNC_PASSWORD=$(VNC_PASSWORD) \
		-e PKGS="vim" \
		simojenki/de