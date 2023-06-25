FROM ubuntu
SHELL ["/bin/bash", "-c"]
RUN addgroup --gid 1024 shared

RUN apt-get update && \
	apt-get install sudo git nano curl gnupg build-essential libpq-dev \
	libjpeg8-dev zlib1g-dev libtiff-dev libfreetype6 libfreetype6-dev \
	libwebp-dev libopenjp2-7-dev libopenjp2-7-dev -y

# Install Crystal
RUN curl -fsSL https://crystal-lang.org/install.sh | sudo bash

# Install Postgres
ARG DEBIAN_FRONTEND=noninteractive
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ jammy-pgdg main" >> /etc/apt/sources.list
RUN curl -fsSL "https://www.postgresql.org/media/keys/ACCC4CF8.asc" | gpg --dearmor > /etc/apt/trusted.gpg.d/postgres.gpg
RUN apt-get update && apt-get install postgresql-14 -y

COPY locale.gen /etc/locale.gen
RUN locale-gen

WORKDIR /tmp/
RUN sudo mv /etc/postgresql/14/main/pg_hba.conf /etc/postgresql/14/main/pg_hba.conf.bak
COPY pg_hba.conf /etc/postgresql/14/main/pg_hba.conf 

WORKDIR /home/dev/milenio_code_challenge
RUN sudo chown :1024 . && sudo chmod 775 . && sudo chmod g+s .

CMD sudo service postgresql start && shards install && make sam db:setup && crystal run src/milenio_code_challenge.cr
