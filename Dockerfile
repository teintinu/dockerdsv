ARG VERSION_ALPINE=3.7
FROM alpine:$VERSION_ALPINE

ARG VERSION_NODEJS=8.9.3-r1
RUN apk --update add git less openssh nodejs=$VERSION_NODEJS bash musl libgcc libstdc++  && \
    rm -rf /var/lib/apt/lists/* && \
    rm /var/cache/apk/*
RUN /usr/bin/ssh-keygen -A
COPY sshd_config /etc/ssh/sshd_config
# RUN /bin/sh /etc/init.d/ssh restart
# RUN rc-update add sshd
# RUN rc-status
#RUN adduser root
#RUN /bin/sh /etc/init.d/sshd restart

VOLUME /root
VOLUME /usr/lib/node_modules
WORKDIR /root

# CMD ["/usr/sbin/sshd", "-D", "-e", "-f", "/etc/ssh/sshd_config"]

RUN echo 'root:123' | chpasswd
# RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
# RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
