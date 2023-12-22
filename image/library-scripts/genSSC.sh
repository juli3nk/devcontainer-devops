#!/usr/bin/env bash
set -e

if [ -z "$1" -o -z "$2" ]; then
  echo -e "genSSC.sh <COMMON NAME> <DAYS>"
  exit 1
fi

CN="$1"
DAYS="$2"

openssl req \
  -new \
  -newkey rsa:2048 \
  -nodes \
  -keyout private.key \
  -out csr.pem \
  -subj "/CN=${CN}"

openssl x509 \
  -req \
  -days "$DAYS" \
  -in csr.pem \
  -signkey private.key \
  -out certificate.crt

rm -f csr.pem
