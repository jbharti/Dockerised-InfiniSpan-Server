FROM ubuntu:20.04

## Set working directory to for deployment ##
WORKDIR /opt/infinispan
ARG APP_VERSION=10.1.8

RUN apt-get update && \
  apt-get install -y --no-install-recommends locales && \
  locale-gen en_US.UTF-8 && \
  apt-get dist-upgrade -y && \  
  apt-get install -y openjdk-8-jdk && \
  apt-get install -y tzdata && \
  apt-get install -y unzip && \
  apt-get install -y zip && \
  apt-get install -y net-tools && \
  apt-get install -y nano && \
  apt-get install -y inetutils-ping && \
  apt-get install -y lsof && \  
  apt-get clean all

COPY infinispan-server-${APP_VERSION}.Final.zip .
RUN mkdir infinispanserver && \
	unzip -o infinispan-server-${APP_VERSION}.Final.zip -d . && \
	mv infinispan-server-${APP_VERSION}.Final/* infinispanserver/

COPY startserver.sh .
RUN chmod a+x /opt/infinispan/startserver.sh && \
	cd /opt/infinispan/infinispanserver/server && mkdir data

COPY infinispan.xml infinispanserver/server/conf 
COPY caches.xml infinispanserver/server/data

RUN cd /opt/infinispan/infinispanserver/server/data/ && ls -al
RUN cd /opt/infinispan/infinispanserver/server/conf/ && ls -al

ENTRYPOINT ["/opt/infinispan/startserver.sh"]




#Image build command
# docker build -t digite/sk-infinispan-server:10.1.8 .
# docker run -p 11222:11222 --name InfiniSpanServer1 -itd digite/sk-infinispan-server:10.1.8
