FROM ubuntu:16.04
MAINTAINER Sven Dowideit <SvenDowideit@docker.com>

RUN apt-get update && apt-get install -y openssh-server  && apt-get install -y python-software-properties software-properties-common
RUN mkdir /var/run/sshd
RUN echo 'root:cw123456' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

RUN apt-get install -y nodejs npm

RUN npm install -g n
RUN n latest

RUN apt-get install -y git-core

RUN git config --global user.name ray
RUN git config --global user.email 77173981@qq.com

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

RUN git clone http://ray:ray123456@code-iacloud.ceway.com.cn/scm/one_card/cw_server.git /cw_server

WORKDIR /cw_server 
RUN npm install --registry=https://registry.npm.taobao.org


ADD run.sh /run.sh
RUN chmod +x /*.sh

EXPOSE 22
EXPOSE 3001

#CMD ["/usr/sbin/sshd", "-D"]
#CMD ["npm", "start"] 
 
#CMD ["/run.sh"]
CMD ["/run.sh"]
