DAEMON_PATH=/home/ubuntu/kafka_2.12-2.5.0
PATH=$PATH:$DAEMON_PATH/bin

echo "Starting Kafka second time"
nohup $DAEMON_PATH/bin/kafka-server-start.sh -daemon $DAEMON_PATH/config/server.properties 2>/dev/null &
echo "Started Kafka second time"
