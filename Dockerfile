FROM confluentinc/cp-kafka-connect-base:5.5.0

RUN cat /etc/confluent/docker/log4j.properties.template

ENV CONNECT_PLUGIN_PATH="/usr/share/java,/usr/share/confluent-hub-components"

ARG JDBC_DRIVER_DIR=/usr/share/java/kafka/

RUN   confluent-hub install --no-prompt confluentinc/kafka-connect-jdbc:5.5.0 \
   && confluent-hub install --no-prompt confluentinc/connect-transforms:1.3.2

ADD java /usr/share/java/
ADD java/kafka-connect-jdbc /usr/share/confluent-hub-components/confluentinc-kafka-connect-jdbc/lib/

ENTRYPOINT ["sh","-c","export CONNECT_REST_ADVERTISED_HOST_NAME=$(hostname -I);/etc/confluent/docker/run"]
