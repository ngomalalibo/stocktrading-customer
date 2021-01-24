DAEMON_PATH=/home/ubuntu/kafka_2.12-2.5.0
PATH=$PATH:$DAEMON_PATH/bin

# See how we were called.
# Stop daemons.
echo "Shutting down Zookeeper"
pid=$(ps ax | grep -i 'org.apache.zookeeper.server' | grep -v grep | awk '{print $1}')
if [ -n "$pid" ]; then
  kill -9 $pid
else
  echo "Zookeeper was not Running"
fi
echo "Shutting down Kafka"
pid=$(ps ax | grep -i 'kafka.Kafka' | grep -v grep | awk '{print $1}')
if [ -n "$pid" ]; then
  kill -9 $pid
else
  echo "Kafka was not Running"
fi
# Start daemon.
echo "Starting Zookeeper"
nohup $DAEMON_PATH/bin/zookeeper-server-start.sh -daemon /$DAEMON_PATH/config/zookeeper.properties 2>/dev/null && \
echo "Starting Kafka"
nohup $DAEMON_PATH/bin/kafka-server-start.sh -daemon /$DAEMON_PATH/config/server.properties 2>/dev/null
exit 0
