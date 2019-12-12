FROM python:3.6-alpine3.8

RUN apk update && apk add --no-cach \
    jpeg-dev \
    zlib-dev \
    build-base \
    && rm -rf /var/cache/apk/*

RUN pip install --no-cache-dir \
  gunicorn[gevent] \
  Flask \
  Flask-Cors \
  pytest \
  requests

RUN apk add tzdata \
    && cp /usr/share/zoneinfo/Asia/Seoul /etc/localtime \
    && echo "Asia/Seoul" > /etc/timezone \
    && apk del tzdata

RUN pip install --no-cache-dir \
    Flask-Opentracing jaeger-client

WORKDIR /code
EXPOSE 5000

COPY ./app /code
ENTRYPOINT ["./docker-entrypoint.sh"]
