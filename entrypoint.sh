#!/bin/bash
set -e
rm -f /app/tmp/pids/server.pid
exec "$@"

# https://rikeiin.hatenablog.com/entry/2021/01/25/163901