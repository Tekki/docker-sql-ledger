#
# this file is generated via docker-builder/generate.pl
#
# do not edit it directly
#
FROM debian:stretch

EXPOSE 80
VOLUME /var/sldata
WORKDIR /var/www/sql-ledger

ENV TEXLIVE_LANG german

RUN set -ex \
  && apt-get update && apt-get install -y --no-install-recommends \
    apache2 \
    ca-certificates \
    gettext-base \
    libdbd-pg-perl \
    libjson-pp-perl \
    pdftk \
    postgresql-client \
    texlive-xetex \
    texlive-fonts-extra \
    wget \
    vim \
  && for lang in "$TEXLIVE_LANG"; do \
    apt-get install -y "texlive-lang-$lang"; \
  done \
  && rm -r /var/lib/apt/lists/*

ENV SL_VERSION 3.2.9.18
ENV SL_TAG v3.2.09.018
ENV SL_URL="https://github.com/Tekki/sql-ledger/archive/$SL_TAG.tar.gz"
ENV SL_SHA256 94b3d7254fab9aa14459f9a11fae8a8cc1f7b049807091e8bd262bfc424cc153

COPY sql-ledger-httpd.conf /etc/apache2/sites-available/sql-ledger.conf

RUN set -ex \
  && mkdir -p /var/sldata \
  && mkdir -p /usr/src \
  && cd /usr/src \
  && wget -q -O sql-ledger.tar.gz "$SL_URL" \
  && if [ -n "$SL_SHA256" ]; then \
    echo "$SL_SHA256 sql-ledger.tar.gz" | sha256sum -c -; \
  fi \
  && tar -xzf sql-ledger.tar.gz -C /var/www/sql-ledger --strip 1 \
  && cd /var/www/sql-ledger \
  && mv css /var/sldata/ && ln -s /var/sldata/css . \
  && mv images /var/sldata/ && ln -s /var/sldata/images . \
  && mv spool /var/sldata/ && ln -s /var/sldata/spool . \
  && mv templates /var/sldata/ && ln -s /var/sldata/templates . \
  && mv users /var/sldata/ && ln -s /var/sldata/users . \
  && sed -ri \
    -e 's~^(\s*CustomLog)\s+\S+~\1 /proc/self/fd/1~g' \
    -e 's~^(\s*ErrorLog)\s+\S+~\1 /proc/self/fd/2~g' \
    /etc/apache2/apache2.conf /etc/apache2/sites-available/*.conf \
  && a2enmod -q cgid \
  && a2ensite -q sql-ledger

ENV SL_DVIPDF 0
ENV SL_HELPFUL_LOGIN 0
ENV SL_LATEX 1
ENV SL_LOGIN_LANGUAGE=
ENV SL_PDFTK 1
ENV SL_SENDMAIL="| /usr/sbin/sendmail -f <%from%> -t"
ENV SL_XELATEX 1

ARG NOW=not-set
LABEL org.opencontainers.image.authors="Tekki <tekki@tekki.ch>"
LABEL org.opencontainers.image.created=$NOW
LABEL org.opencontainers.image.description="SQL-Ledger is an open source ERP and accounting system."
LABEL org.opencontainers.image.documentation=https://github.com/Tekki/docker-sql-ledger/blob/master/README.md
LABEL org.opencontainers.image.licenses=Artistic-2.0
LABEL org.opencontainers.image.source=https://github.com/Tekki/docker-sql-ledger/blob/master/main/Dockerfile
LABEL org.opencontainers.image.title=SQL-Ledger
LABEL org.opencontainers.image.url=https://github.com/Tekki/docker-sql-ledger
LABEL org.opencontainers.image.version=3.2.9.18

COPY sql-ledger.conf /usr/src
COPY wlprinter.conf ./
COPY docker-entrypoint.sh /usr/local/bin
RUN chmod 0755 /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
