FROM adoptopenjdk:11-jre-hotspot-bionic

LABEL "X" "aba1"

VOLUME /opt/restheart/etc
       
RUN cd /opt && \
  curl -LJO https://github.com/SoftInstigate/restheart/releases/download/5.0.0/restheart.tar.gz && \
  tar -xzf restheart.tar.gz && \ 
  rm restheart.tar.gz

WORKDIR /opt/restheart
RUN find /opt/restheart

ENTRYPOINT [ "java", "-Dfile.encoding=UTF-8", "-server", "-jar", "restheart.jar", "etc/restheart.yml", '-e', 'etc/default.properties']
# CMD ["--envFile", "etc/default.properties"]
EXPOSE 8009 8080 4443
