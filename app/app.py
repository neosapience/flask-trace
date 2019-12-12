import logging
import opentracing
from flask_opentracing import FlaskTracing
import jaeger_client
from flask import Flask


def initialize_tracer():
    log_level = logging.DEBUG
    logging.getLogger('').handlers = []
    logging.basicConfig(format='%(asctime)s %(message)s', level=log_level)
    config = jaeger_client.Config(
        config={ # usually read from some yaml config
            'sampler': {
                'type': 'const',
                'param': 1,
            },
            'logging': True,
        },
        service_name='flask-tracing-app',
        validate=True,
    )
    # return config.initialize_tracer(io_loop=ioloop.IOLoop.current())
    return config.initialize_tracer()


app = Flask(__name__)
tracing = FlaskTracing(initialize_tracer, True, app)


@app.route('/')
def hello():
    return f'Hello, world!\n'
