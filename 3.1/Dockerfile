FROM debian:jessie

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN groupadd -r atlassian && useradd -r -g atlassian atlassian

# grab gosu for easy step-down from root
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/* \
  && curl -o /usr/local/bin/gosu -SL 'https://github.com/tianon/gosu/releases/download/1.1/gosu' \
  && chmod +x /usr/local/bin/gosu \
  && apt-get purge -y --auto-remove curl

# grab the stash dependencies
RUN apt-get update && apt-get install -y \
    openjdk-7-jre-headless \
    libtcnative-1 \
    git \
    perl \
  && rm -rf /var/lib/apt/lists/*

ENV STASH_VERSION 3.1.7

# extract stash
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/* \
  && mkdir -p /opt/atlassian \
  && curl -s -o /opt/atlassian/atlassian-stash.tar.gz -SL 'http://www.atlassian.com/software/stash/downloads/binary/atlassian-stash-3.1.7.tar.gz' \
  && tar xf /opt/atlassian/atlassian-stash.tar.gz -C /opt/atlassian --strip-components=1 \
  && rm -f /opt/atlassian/atlassian-stash.tar.gz \
  && mkdir -p /opt/atlassian/lib/native \
  && ln -s /usr/lib/x86_64-linux-gnu/libtcnative-1* /opt/atlassian/lib/native \
  && chown -R atlassian /opt/atlassian \
  && apt-get purge -y --auto-remove curl

ENV STASH_HOME /var/atlassian/stash
VOLUME /var/atlassian/stash

COPY ./docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]

# http(s), ssh
EXPOSE 7990 7999
CMD ["stash"]