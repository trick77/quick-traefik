#!/usr/bin/env bash
#
# This script generates a htpasswd entry with proper escaping for Traefik's basic
# authentication mechanism, making it suitable to use in a Docker Compose label.

usage() {
  echo "Usage: $0 <username> <password>"
  exit 1
}

if [ "$#" -ne 2 ]; then
  echo "Error: Invalid number of parameters."
  usage
fi

if ! command -v htpasswd > /dev/null; then
  echo "Error: htpasswd command not found. Please install it before using this script."
  exit 1
fi

username="$1"
password="$2"

echo $(htpasswd -nbB "$username" "$password") | sed -e s/\\$/\\$\\$/g
