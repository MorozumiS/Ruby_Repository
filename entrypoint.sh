#!/bin/bash
set -e

rm -f /Training_Theme/tmp/pids/server.pid

exec "$@"