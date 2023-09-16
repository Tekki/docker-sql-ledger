#! /bin/bash
#
# this file is generated via docker-builder/generate.pl
#
# do not edit it directly
#

envsubst '${SL_DVIPDF},${SL_HELPFUL_LOGIN},${SL_LATEX},${SL_LOGIN_LANGUAGE},${SL_PDFTK},${SL_SENDMAIL},${SL_XELATEX}' < /usr/src/sql-ledger.conf > sql-ledger.conf

FOLDERS="images spool templates users"
for FOLDER in $FOLDERS; do
    if [ ! -f /var/sldata/$FOLDER ]; then
        cp -r $FOLDER /var/sldata/
    fi

    chown -hR www-data:www-data /var/sldata/$FOLDER
    rm -r $FOLDER
    ln -s /var/sldata/$FOLDER .
done

exec "$@"
