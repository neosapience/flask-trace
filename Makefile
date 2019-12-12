.PHONY: build up push

build:
	@docker build . -t zironycho/flask-trace

up:
	@docker run --rm -it -p 5000 zironycho/flask-trace \
		gunicorn --log-level=debug -k=gevent

push:
	@docker push zironycho/flask-trace
