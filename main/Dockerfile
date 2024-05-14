#
# this file is generated via docker-builder/generate.pl
#
# do not edit it directly
#
FROM debian:bookworm

EXPOSE 80
VOLUME /var/sldata
WORKDIR /var/www/sql-ledger

ENV TEXLIVE_LANG german

RUN set -ex \
  && apt-get update && apt-get install -y --no-install-recommends \
    apache2 \
    ca-certificates \
    gettext-base \
    libarchive-extract-perl \
    libarchive-zip-perl \
    libdbd-pg-perl \
    libexcel-writer-xlsx-perl \
    libio-socket-ssl-perl \
    libmojolicious-perl \
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

ENV SL_VERSION 3.2.12.42
ENV SL_TAG v3.2.12.042
ENV SL_URL="https://codeload.github.com/Tekki/sql-ledger/tar.gz/$SL_TAG"
ENV SL_SHA256 07ab78fbaf4ad028c937740c00e1d1c280e7221c3615c6e47b091f1102b1ba3b

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
LABEL org.opencontainers.image.version=3.2.12.42

COPY sql-ledger.conf /usr/src
COPY wlprinter.conf ./
COPY docker-entrypoint.sh /usr/local/bin
RUN chmod 0755 /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
