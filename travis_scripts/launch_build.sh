sudo apt-get remove docker docker-engine docker.io containerd runc
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io
gem install travis
sudo rm /usr/local/bin/docker-compose
curl -L https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m) >docker-compose
chmod +x docker-compose
sudo mv docker-compose /usr/local/bin
echo "Launching $BUILD_NAME IN AMAZON ECS"
docker container rm -f $(docker container ls -aq)
docker image rm -f $(docker image ls -aq)
docker-compose up -d
docker-compose ps -a
docker ps -a
