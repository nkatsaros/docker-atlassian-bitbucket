#!/bin/bash
set -e

if [ "$1" = 'bitbucket' ]; then
  chown -R atlassian "$BITBUCKET_HOME"
  umask 0027
  exec gosu atlassian /opt/atlassian/bin/start-bitbucket.sh -fg
fi

exec "$@"