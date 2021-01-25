sudo chmod 600 all-stock-key-pair.pem
sudo chmod 755 ~/
echo "Copying files to AWS instance"
scp -i all-stock-key-pair.pem docker-compose.yml ubuntu@ec2-3-124-206-1.eu-central-1.compute.amazonaws.com:.
scp -i all-stock-key-pair.pem .env ubuntu@ec2-3-124-206-1.eu-central-1.compute.amazonaws.com:.
scp -i all-stock-key-pair.pem travis_scripts/launch_build.sh ubuntu@ec2-3-124-206-1.eu-central-1.compute.amazonaws.com:.

echo "Copying Kafka scripts to AWS Instance"
#Start Kafka
yes | scp -i all-stock-key-pair.pem travis_scripts/kafkainit.sh ubuntu@ec2-3-120-98-15.eu-central-1.compute.amazonaws.com:.
yes | scp -i all-stock-key-pair.pem travis_scripts/start_kafka.sh ubuntu@ec2-3-120-98-15.eu-central-1.compute.amazonaws.com:.
echo "Starting Kafka and Zookeeper"
ssh -i "all-stock-key-pair.pem" ubuntu@ec2-3-120-98-15.eu-central-1.compute.amazonaws.com 'bash kafkainit.sh'
echo "Going back to start Kafka>>>>>>"
ssh -i "all-stock-key-pair.pem" ubuntu@ec2-3-120-98-15.eu-central-1.compute.amazonaws.com 'sh start_kafka.sh'
echo "Started Kafka and Zookeeper"

echo "Tagging build with $BUILD_NAME"
export TARGET_URL="https://api.github.com/repos/ngomalalibo/stocktradingmicroservices/releases?access_token=$GITHUB_TOKEN"

body="{
  \"tag_name\": \"$BUILD_NAME\",
  \"target_commitish\": \"master\",
  \"name\": \"$BUILD_NAME\",
  \"body\": \"Release of version $BUILD_NAME\",
  \"draft\": true,
  \"prerelease\": true
}"

curl -k -X POST \
-H "Content-Type: application/json" \
-d "$body" \
$TARGET_URL
