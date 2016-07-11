FROM ubuntu:14.04
MAINTAINER Krzysztof Szumny <noisy.pl@gmail.com>

RUN apt-get update && apt-get install -y python-pip && pip install awscli

ADD backup.sh /backup.sh
ADD restore.sh /restore.sh
ADD run.sh /run.sh
RUN chmod 755 /*.sh

CMD ["/run.sh"]
