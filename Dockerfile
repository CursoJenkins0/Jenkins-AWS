FROM centos:7
RUN yum -y install openssh-server passwd

RUN useradd remote_user && \
    echo "1234" | passwd remote_user  --stdin && \
    mkdir /home/remote_user/.ssh && \
    chmod 700 /home/remote_user/.ssh

COPY remote-key.pub /home/remote_user/.ssh/authorized_keys

RUN chown remote_user:remote_user   -R /home/remote_user && \
    chmod 600 /home/remote_user/.ssh/authorized_keys

RUN /usr/bin/ssh-keygen -A
RUN rm -rf /run/nologin
RUN yum -y install mysql

RUN yum -y install epel-release && \
    yum -y install python-pip && \
    pin install --upgrade pip && \
    pip2.7  install awscli

EXPOSE 22
CMD /usr/sbin/sshd -D
