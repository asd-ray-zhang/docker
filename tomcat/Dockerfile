FROM ubuntu:16.04
MAINTAINER ray "achievorayzhang@gmail.com"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get install -y software-properties-common python-software-properties

RUN add-apt-repository ppa:webupd8team/java

RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:123456' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

RUN apt-get install -y vim
RUN apt-get install -y wget
RUN apt-get install -y curl

#install jdk8
RUN echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y oracle-java8-installer && \
  apt-get clean

ADD tomcat8 /tomcat8
ADD run.sh /run.sh
RUN chmod +x /*.sh


ENV CATALINA_HOME /tomcat8
ENV PATH $CATALINA_HOME/bin:$PATH

RUN chmod +x /tomcat8/bin/*.sh

EXPOSE 22
EXPOSE 8080


#ENTRYPOINT ["/usr/sbin/sshd", "-D"]
CMD ["/run.sh"]


