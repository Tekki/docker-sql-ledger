#! /bin/bash
#
# this file is generated via docker-builder/update.pl
#
# do not edit it directly
#

if [ ! -f /var/sldata/etc/sql-ledger.conf ]; then
  cp /var/www/sql-ledger/sql-ledger.conf.default /var/sldata/etc/sql-ledger.conf
fi
ln -s /var/sldata/etc/sql-ledger.conf /var/www/sql-ledger/sql-ledger.conf

if [ ! -f /var/sldata/etc/wlprinter.conf ]; then
  cp /var/www/sql-ledger/wlprinter.conf.default /var/sldata/etc/wlprinter.conf
fi
ln -s /var/sldata/etc/wlprinter.conf /var/www/sql-ledger/wlprinter.conf

chown -hR www-data:www-data css/ spool/ templates/ users/

exec "$@"
