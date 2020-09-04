import os
from flask import Flask

app = Flask(__name__)
cache = {'counter': 0}


@app.route('/', methods=['GET'])
def index():
    cache['counter'] += 1
    return "It's REALLY ALIVE GUYS!, counter: {}...".format(cache['counter'])


if __name__ == '__main__':
    app.run(threaded=True, host=os.getenv('HOST', '0.0.0.0'), port=os.getenv('PORT', 8000))
