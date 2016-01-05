FROM ubuntu:14.04

RUN apt-get -y update && apt-get -y install build-essential zlib1g-dev libssl-dev libreadline6-dev libyaml-dev wget

# install ruby 2.1.5
RUN cd /tmp && wget http://ftp.ruby-lang.org/pub/ruby/2.1/ruby-2.1.5.tar.gz
RUN cd /tmp && tar -xvzf ruby-2.1.5.tar.gz
RUN cd /tmp/ruby-2.1.5/ && ./configure --prefix=/usr/local
RUN cd /tmp/ruby-2.1.5/ && make
RUN cd /tmp/ruby-2.1.5/ && make install

# Install all gems:
RUN gem install serverspec
RUN gem install docker-api
