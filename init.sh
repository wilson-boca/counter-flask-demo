#!/bin/bash
set -e

echo "Starting SSH server..."
service ssh start

gunicorn --bind $HOST:$PORT --workers 1 --log-level=DEBUG --threads 8 app:app