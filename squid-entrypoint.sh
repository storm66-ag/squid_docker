#!/bin/bash
set -e


echo "Starting squid..."

exec $(which squid) -f /etc/squid/squid.conf -NYCd 1

