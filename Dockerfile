FROM hub.boqii.com/bq/ubuntu:16.04
MAINTAINER zhangzw zhangzw@boqii.com

copy xunsearch-full-1.4.7.tar.bz2 /root

ENV LANG zh_CN.utf8
ENV LANGUAGE zh_CN.utf8

RUN apt-get update \
 && apt-get install net-tools  language-pack-zh-hans -y \
 && apt-get install -qy --no-install-recommends  make gcc g++ bzip2 zlib1g-dev \
 && apt-get clean \
 && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
 && echo 'Asia/Shanghai' >/etc/timezone \
 && cd /root \
 && tar -xvf xunsearch-full-1.4.7.tar.bz2 \
 && cd /root/xunsearch-full-1.4.7 && sh setup.sh --prefix=/usr/local/xunsearch \
 && echo '' >> /usr/local/xunsearch/bin/xs-ctl.sh \
 && echo 'tail -f /dev/null' >> /usr/local/xunsearch/bin/xs-ctl.sh \
 && rm -rf /var/lib/apt/lists/* \
 && apt-get purge -y --auto-remove make gcc g++ bzip2 zlib1g-dev \
 && rm -rf /root/xunsearch-full-1.4.7*

# Configure it
#VOLUME ["/usr/local/xunsearch/data"]
EXPOSE 8383
EXPOSE 8384

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
