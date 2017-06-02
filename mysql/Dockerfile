FROM ubuntu:16.04
MAINTAINER ray <77173981@qq.com>
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y openssh-server  && apt-get install -y python-software-properties software-properties-common
RUN mkdir /var/run/sshd
RUN echo 'root:cw123456' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

RUN apt-get update && \
  apt-get -yq install mysql-server-5.7 pwgen && \
  rm -rf /var/lib/apt/lists/*

  # 删除预安装的数据库文件
#RUN rm -rf /var/lib/mysql/*

# 添加文件夹下的 MYSQL 配置文件
#ADD my.cnf /etc/mysql/conf.d/my.cnf
#ADD mysqld_charset.cnf /etc/mysql/conf.d/mysqld_charset.cnf


RUN apt-get update && apt-get install -y vim

# 添加 MYSQL 的脚本
#ADD import_sql.sh /import_sql.sh
ADD run.sh /run.sh
RUN chmod 755 /*.sh


# 设置环境变量，用户名以及秘密
#ENV MYSQL_USER admin
#ENV MYSQL_PASS admin

RUN mkdir /var/run/mysqld/
RUN chown -R mysql:mysql /var/run/mysqld/

# 设置可以允许挂载的卷，可以用来备份数据库和配置文件
VOLUME  ["/etc/mysql", "/var/lib/mysql"]

# 设置可以映射的端口，如果是从我们的 sshd 镜像继承的话，默认还会开启 22 端口
EXPOSE 3306
EXPOSE 22
CMD ["/run.sh"]

#CMD ["/usr/sbin/sshd", "-D"]
