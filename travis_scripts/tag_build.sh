sudo chmod 600 all-stock-key-pair.pem
sudo chmod 755 ~/
echo "Copying files to AWS instance"
scp -i all-stock-key-pair.pem docker-compose.yml ubuntu@ec2-3-121-40-225.eu-central-1.compute.amazonaws.com:.
scp -i all-stock-key-pair.pem travis_scripts/launch_build.sh ubuntu@ec2-3-121-40-225.eu-central-1.compute.amazonaws.com:.
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
