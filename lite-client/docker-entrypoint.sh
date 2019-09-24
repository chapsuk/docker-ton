#!/usr/bin/dumb-init /bin/sh

set -e

set -- su-exec ton:ton "$@"
exec "$@"
