# Docker container for Postgis

FROM jmarin/supervisor
MAINTAINER Juan Marin Otero <juan.marin.otero@gmail.com>

ADD OpenGeo.repo /etc/yum.repos.d/OpenGeo.repo

RUN yum -y install postgis21-postgresql93; yum clean all

RUN service postgresql-9.3 initdb
RUN service postgresql-9.3 start && /bin/su postgres -c "createuser -d -s -r -l docker" && /bin/su postgres -c "psql postgres -c \"ALTER USER docker WITH ENCRYPTED PASSWORD 'docker'\"" && service postgresql-9.3 stop
RUN echo "listen_addresses = '*'" >> /var/lib/pgsql/9.3/data/postgresql.conf
RUN echo "port = 5432" >> /var/lib/pgsql/9.3/data/postgresql.conf

ENV PGDATA /var/lib/pgsql/9.3/data

EXPOSE 5432

ADD postgis.sv.conf /etc/supervisor/conf.d/

CMD ["supervisord", "-c", "/etc/supervisor/supervisor.conf"]

