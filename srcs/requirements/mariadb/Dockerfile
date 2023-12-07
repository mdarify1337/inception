FROM debian:11

RUN apt -y update && apt -y upgrade

RUN apt -y install mariadb-server

RUN mkdir -p /run/mysqld 


# RUN echo "" > /etc/mysql/mariadb.conf.d/50-server.cnf
COPY ./conf/50-server.cnf ./etc/mysql/mariadb.conf.d

# RUN apt update -y && \ 
#     apt install mariadb mariadb-client  && \
# 	mkdir -p /run/mysqld && \
# 	chown -R mysql:mysql /run/mysqld && \
#     mysql_install_db --user=mysql --datadir=/var/lib/mysql && \
# 	chown -R mysql:mysql /var/lib/mysql && \
# RUN sed -i 's/skip-networking/#skip-networking/g' /etc/mysql/mariadb.conf.d/50-server.cnf
# RUN sed -i 's/#bind-address/bind-address = 0.0.0.0/g' /etc/mysql/mariadb.conf.d/50-server.cnf

COPY ./tools/script.sh /tmp/script.sh

RUN chmod +x /tmp/script.sh

WORKDIR /tmp

CMD ./script.sh