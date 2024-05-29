FROM nginx:1.25.4
RUN apt-get update -y
RUN apt install sudo -y
RUN sudo apt install nano -y

COPY ./index.html /usr/share/nginx/html/
COPY ./ring.css /usr/share/nginx/html/

