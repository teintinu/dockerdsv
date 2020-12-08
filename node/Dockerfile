FROM ubuntu:latest

SHELL ["/bin/bash", "--login", "-c"]

ENV DEBIAN_FRONTEND=noninteractive
RUN ln -fs /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
RUN apt-get update && \
    apt-get install -y git less libc6 libstdc++6 python2 ca-certificates tar openssh-server bash wget tzdata build-essential libssl-dev
RUN dpkg-reconfigure --frontend noninteractive tzdata

# Install nvm with node and npm
ENV NVM_DIR /usr/local/nvm
RUN mkdir -p $NVM_DIR
ENV NODE_VERSION v12.18.1
RUN wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash \
    && source $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH      $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH



RUN mkdir /var/run/sshd
RUN /usr/bin/ssh-keygen -A
COPY sshd_config /etc/ssh/sshd_config

# RUN /bin/sh /etc/init.d/ssh restart
# RUN rc-update add sshd
# RUN rc-status
#RUN adduser root
#RUN /bin/sh /etc/init.d/sshd restart

VOLUME /git
VOLUME /usr/lib/node_modules
WORKDIR /git

# CMD ["/usr/sbin/sshd", "-D", "-e", "-f", "/etc/ssh/sshd_config"]

RUN echo 'root:123' | chpasswd
# RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
# RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22
EXPOSE 3000

VOLUME /root/.ssh
VOLUME /root/.git
VOLUME /root/.gitconfig
VOLUME /root/.config
VOLUME /root/.vscode-server
VOLUME /root/ssl

CMD ["/usr/sbin/sshd", "-D"]
