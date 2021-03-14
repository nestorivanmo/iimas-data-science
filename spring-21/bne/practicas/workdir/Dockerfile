FROM ubuntu:focal

RUN apt-get update && apt-get install -y build-essential wget \
 && wget download.redis.io/releases/redis-stable.tar.gz \
 && tar -xzf redis-stable.tar.gz \
 && cd redis-stable && make && make install \
 && cd .. \
 && rm redis-stable.tar.gz \
 && rm -r redis-stable \
 && apt-get remove -y build-essential wget

WORKDIR redis-conf

COPY redis.conf .

ENTRYPOINT ["redis-server"]
CMD ["--protected-mode no"]

VOLUME /source
EXPOSE 6379


