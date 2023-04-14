#get base image
FROM nginx
#author label
LABEL org.opencontainers.image.authors="https://github.com/Kev-Soft/"

RUN apt-get update && apt-get upgrade -y

#copy all website files - in this case we use index.html
COPY index.html /usr/share/nginx/html/index.html

EXPOSE 8080
