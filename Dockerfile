curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive.gpg

echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update
sudo apt install -y docker-ce
sudo systemctl start docker
sudo systemctl enable docker
sudo docker --version
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker
docker run hello-world
