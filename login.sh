#!/usr/bin/env bash

. config.sh
. common.sh

if [ $# -eq 0 ]; then
	cat >&2 <<EOF
usage: $0 mdw
    or $0 mdw cmd args
    or $0 mdw -- cmd args

EOF
	exit 1
fi

alias=$1
shift

host=${prefix}-${os}-${alias}

if [ "$1" = '--' ]; then
	shift
fi

cat 2>&2 <<EOF
HINT: to use the cluster please source below files

    . $gphome/greenplum_path.sh
    . $gpdata/me.env

EOF

ip=$(gcp_get_external_ip $host)
ssh -t -- $ip "$@"
