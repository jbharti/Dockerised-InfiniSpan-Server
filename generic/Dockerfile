FROM infinispan-server:10.1.8.v2
RUN  cd /opt/infinispan-server/server/ && mkdir data
COPY caches.xml /opt/infinispan-server/server/data
ENTRYPOINT ["./docker-entrypoint.sh"]
