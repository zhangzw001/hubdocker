FROM ubuntu:16.04
MAINTAINER zhangzw zhangzw@boqii.com

ENV XUNSEARCH_VERSION 1.4.9

RUN apt-get update \
 && apt-get install -qy --no-install-recommends  wget make gcc g++ bzip2 zlib1g-dev \
 && apt-get clean \
 && cd /root \
 && wget http://www.xunsearch.com/download/xunsearch-full/xunsearch-full-$XUNSEARCH_VERSION.tar.bz2 \
 && tar -xf xunsearch-full-$XUNSEARCH_VERSION.tar.bz2 \
 && cd xunsearch-full-$XUNSEARCH_VERSION \
 && sh setup.sh --prefix=/usr/local/xunsearch \
 && echo '' >> /usr/local/xunsearch/bin/xs-ctl.sh \
 && echo 'tail -f /dev/null' >> /usr/local/xunsearch/bin/xs-ctl.sh \
 && apt-get purge -y --auto-remove wget make gcc g++ bzip2 zlib1g-dev \
 && rm -rf /var/lib/apt/lists/* \
 && rm -rf /root/xunsearch-full-*


# Configure it
VOLUME ["/usr/local/xunsearch/data"]
EXPOSE 8383 8384

WORKDIR /usr/local/xunsearch
RUN echo "#!/bin/sh" > bin/xs-docker.sh \
    && echo "rm -f tmp/pid.*" >> bin/xs-docker.sh \
    && echo "echo -n > tmp/docker.log" >> bin/xs-docker.sh \
    && echo "bin/xs-indexd -l tmp/docker.log -k start" >> bin/xs-docker.sh \
    && echo "sleep 1" >> bin/xs-docker.sh \
    && echo "bin/xs-searchd -l tmp/docker.log -k start" >> bin/xs-docker.sh \
    && echo "sleep 1" >> bin/xs-docker.sh \
    && echo "tail -f tmp/docker.log" >> bin/xs-docker.sh

ENTRYPOINT ["sh"]
CMD ["bin/xs-docker.sh"]
