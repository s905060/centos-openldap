#!/bin/bash

set -e

if [[ ! -f /var/lib/ldap/DB_CONFIG ]]; then
  cp /usr/share/openldap-servers/DB_CONFIG.example /var/lib/ldap/DB_CONFIG
fi

chown -R openldap:openldap /var/lib/ldap /etc/openldap/slapd.d

if [[ ! -z "$MAX_NOFILE" ]]; then
  ulimit -n "$MAX_NOFILE"
fi

exec slapd -d 3000 -u openldap -g openldap -h "$SLAPD_URL"
