#!/bin/sh

# Find the user's UID and GID from their work directory and create a
# container user

UID="$(stat -c %u /app/main.py)"
GID="$(stat -c %g /app/main.py)"

addgroup -g "$GID" vscode
adduser -h /app -G vscode -D -H -u "$UID" vscode

exec su vscode -c 'exec "$0" "$@"' -- "$@"
