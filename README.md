# docker image creation
Short tutorial on how to create a docker image based
on Nginx with own website files


Requirements: installed Docker
> Update the apt package index and install packages to allow apt to use a repository over HTTPS:
``` 
sudo apt-get update
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg 
```


> Add Docker’s official GPG key:
```
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
```


> Use the following command to set up the repository:
```echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```
  
  
> Update the apt package index:
```
sudo apt-get update
```


> To install the latest version, run:
```
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```
more on: official [Docker documentation](https://docs.docker.com/engine/install/ubuntu/)




## Lets get started with docker image creation
1.create a directory for all you files
```
mkdir webserver
cd webserver
```

2.create a folder and copy your website files into it,
in this case we just use a simple index.html
```
nano index.html
```
```
<!DOCTYPE html>
<html lang="de">
  <head>
    <meta charset="utf-8">
    <title>NGINX - Website</title>
  </head>
  <body>
        Hello from your Website.
  </body>
</html>
```


3.create a file called "Dockerfile"
```
#get base image
FROM nginx
#author label
LABEL org.opencontainers.image.authors="https://github.com/Kev-Soft/"

RUN apt-get update && apt-get upgrade -y

#copy all website files - in this case we use index.html
COPY index.html /usr/share/nginx/html/index.html

EXPOSE 8080
```

4.build docker image and tag it - 
```
docker build -t webserver:v1 .

#make sure to edit it to you dockerhub-rep
#example: docker tag webserver:v1 your-dockerhub-rep/webserver:v1

docker tag webserver:v1 dothavoc/webserver:v1
```

5.push it to docker hub
```
docker login
docker push dothavoc/webserver:v1
```

6. pull and run it
```
docker pull dothavoc/webserver:v1
docker run dothavoc/webserver:v1
```
