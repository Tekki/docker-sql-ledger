<!-- this file is generated via docker-builder/generate.pl, do not edit it directly -->
# What is SQL-Ledger?

[SQL-Ledger](https://sql-ledger.com) is an open source ERP and accounting system.

It gives you all the functionality you need for quotations, order management,
invoices, payrolls and much more. The program is written in
[Perl](https://www.perl.org), runs on an [Apache](https://httpd.apache.org)
webserver, uses a [PostgreSQL](https://www.postgresql.org) database and is
highly configurable.

For more informations about SQL-Ledger and the code used for this image please
visit [github.com/Tekki/sql-ledger](https://github.com/Tekki/sql-ledger).

# Supported tags and respective Dockerfile links

* SQL-Ledger improved by Tekki: [3.2.9.18, latest (main/Dockerfile)](https://github.com/Tekki/docker-sql-ledger/blob/master/main/Dockerfile).
* SQL-Ledger original version by DWS: [3.2.9, dws (dws/Dockerfile)](https://github.com/Tekki/docker-sql-ledger/blob/master/dws/Dockerfile).

# How to use this image

Starting a SQL-Ledger instance is simple:

    $ docker run -d --name my-sql-ledger -p 80:80 tekki/sql-ledger:tag

The database is expected to run in a separate container and XeTeX is used as
PDF engine.

You find a sample compose file at
[samples/docker-compose.yml](https://github.com/Tekki/docker-sql-ledger/blob/master/samples/docker-compose.yml).

## Environment Variables

| Name | Default Value | Description |
| - | - | - |
| SL\_DVIPDF | 0 | use dvipdf instead of pdflatex |
| SL\_HELPFUL\_LOGIN | 0 | helpful error messages on login screen |
| SL\_LATEX | 1 | use LaTeX |
| SL\_LOGIN\_LANGUAGE | | language of the login screen |
| SL\_PDFTK | 1 | use pdftk to combine PDFs |
| SL\_SENDMAIL | "\| /usr/sbin/sendmail -f <%from%> -t" | pipe to sendmail |
| SL\_XELATEX | 1 | use XeLaTex instead of pdflatex |

## Folder Structure

The container will create and use a volume located at `/var/sldata` with the
following structure:

    ├ css
    ├ images
    ├ spool
    ├ templates
    └ users

# Source

The source of this image on [GitHub](https://github.com/Tekki/docker-sql-ledger).
