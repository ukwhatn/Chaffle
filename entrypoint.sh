#!/bin/bash
set -e

# kill running puma
rm -f /app/tmp/pids/server.pid

# start server
exec "$@"
