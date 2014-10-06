# Docker container for Postgis
# To build, run docker build --rm -t=jmarin/postgis
# A container with a running postgis database can be started by running docker run -p 5432:5432 jmarin/postgis

FROM jmarin/supervisor
MAINTAINER Juan Marin Otero <juan.marin.otero@gmail.com>

ADD OpenGeo.repo /etc/yum.repos.d/OpenGeo.repo

RUN yum -y install postgis21-postgresql93; yum clean all

RUN service postgresql-9.3 initdb
RUN service postgresql-9.3 start && /bin/su postgres -c "createuser -d -s -r -l docker" && /bin/su postgres -c "psql postgres -c \"ALTER USER docker WITH ENCRYPTED PASSWORD 'docker'\"" && service postgresql-9.3 stop
RUN service postgresql-9.3 start && /bin/su postgres -c "createdb --owner docker docker" && service postgresql-9.3 stop
RUN echo "host all  all    0.0.0.0/0  md5" >> /var/lib/pgsql/9.3/data/pg_hba.conf
RUN echo "listen_addresses = '*'" >> /var/lib/pgsql/9.3/data/postgresql.conf
RUN echo "port = 5432" >> /var/lib/pgsql/9.3/data/postgresql.conf

ENV PGDATA /var/lib/pgsql/9.3/data

EXPOSE 5432

ADD postgis.sv.conf /etc/supervisor/conf.d/

CMD ["supervisord", "-c", "/etc/supervisor/supervisor.conf"]

