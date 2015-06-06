FROM phusion/baseimage:0.9.16
MAINTAINER MATSUI Shinsuke <poppen.jp@gmail.com>

RUN apt-get update && \
    apt-get install -y \
        vlc \
        ruby2.0
RUN sed -i 's/geteuid/getppid/' /usr/bin/vlc

RUN rm /usr/bin/ruby /usr/bin/gem /usr/bin/irb /usr/bin/rdoc /usr/bin/erb && \
    ln -s /usr/bin/ruby2.0 /usr/bin/ruby && \
    ln -s /usr/bin/gem2.0 /usr/bin/gem && \
    ln -s /usr/bin/irb2.0 /usr/bin/irb && \
    ln -s /usr/bin/rdoc2.0 /usr/bin/rdoc && \
    ln -s /usr/bin/erb2.0 /usr/bin/erb && \
    gem update --system && \
    gem pristine --all

RUN cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

RUN gem install thor

COPY radiru_rec.rb /usr/local/bin/
RUN chmod +x /usr/local/bin/radiru_rec.rb

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]
