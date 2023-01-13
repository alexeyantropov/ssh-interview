#!/usr/bin/python3
import sys
from flask import Flask
from flask import request

app = Flask(__name__)

@app.route('/')
def root():
    return('Try to get URL \'/secret\'\n', 403)

@app.route('/secret')
def secret():
    return('You win!\n', 200)

def log(m: str):
    log = '/tmp/start-me/start-me.log'
    try:
        fd = open(log, 'w')
    except:
        sys.exit(1)
    fd.write(m + '\n')
    fd.close

def main():
    log('Try to start a web server!')
    try:
        app.run(host='0.0.0.0', port=8080)
    except Exception as err:
        log(str(err))
    return True

if __name__ == '__main__':
    main()