#! /bin/bash
#
# this file is generated via docker-builder/generate.pl
#
# do not edit it directly
#

envsubst '${SL_DVIPDF},${SL_HELPFUL_LOGIN},${SL_LATEX},${SL_LOGIN_LANGUAGE},${SL_PDFTK},${SL_SENDMAIL},${SL_XELATEX}' < /usr/src/sql-ledger.conf > sql-ledger.conf
chown -hR www-data:www-data css/ spool/ templates/ users/

exec "$@"
