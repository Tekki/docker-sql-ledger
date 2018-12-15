#
# this file is generated via docker-builder/update.pl
#
# do not edit it directly
#

FROM debian:stretch
LABEL maintainer="Rolf Stöckli (Tekki) <tekki@tekki.ch>"

RUN set -e; \
    apt-get update && apt-get install -y --no-install-recommends \
    texlive-xetex \
    texlive-fonts-extra

RUN set -e; \
    apt-get install -y --no-install-recommends \
    apache2 \
    ca-certificates \
    libdbd-pg-perl \
    libjson-pp-perl \
    pdftk \
    postgresql-client \
    wget \
    vim

ENV SL_VERSION 3.2.7.1-e
ENV SL_TAG v3.2.07.001-e
ENV SL_URL="https://github.com/Tekki/sql-ledger/archive/$SL_TAG.tar.gz"
ENV TEXLIVE_LANG german

RUN set -e; \
    for lang in "$TEXLIVE_LANG"; do \
      apt-get install -y "texlive-lang-$lang"; \
    done; \
    rm -r /var/lib/apt/lists/*

COPY sql-ledger-httpd.conf /etc/apache2/sites-available/sql-ledger.conf

RUN set -e; \
    mkdir -p /var/sldata/etc; \
    mkdir -p /var/www/sql-ledger; \
    mkdir -p /usr/src; \
    cd /usr/src; \
    wget -q -O sql-ledger.tar.gz "$SL_URL" && \
    if [ -n "$SL_SHA256" ]; then \
      echo "$SL_SHA256 sql-ledger.tar.gz" | sha256sum -c -; \
    fi; \
    tar -xzf sql-ledger.tar.gz -C /var/www/sql-ledger --strip 1; \
    cd /var/www/sql-ledger; \
    mv css /var/sldata/ && ln -s /var/sldata/css .; \
    mv images /var/sldata/ && ln -s /var/sldata/images .; \
    mv users /var/sldata/ && ln -s /var/sldata/users .; \
    mv templates /var/sldata/ && ln -s /var/sldata/templates .; \
    mv spool /var/sldata/ && ln -s /var/sldata/spool .; \
    a2enmod -q cgid; a2ensite -q sql-ledger

VOLUME /var/sldata
WORKDIR /var/www/sql-ledger
EXPOSE 80

COPY docker-entrypoint.sh /usr/local/bin
RUN chmod 0755 /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
