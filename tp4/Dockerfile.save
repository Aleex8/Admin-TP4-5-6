FROM internetsystemsconsortium/bind9:9.18
RUN apt update
RUN apt install -y nano net-tools
COPY /config/named.conf /etc/bind/named.conf
COPY /config/l1-9.zone /etc/bind/l1-9.zone

RUN chown -R bind:bind /etc/bind/

CMD ["/usr/sbin/named", "-g", "-c", "/etc/bind/named.conf", "-u", "bind"]
