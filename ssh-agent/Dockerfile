FROM alpine:3.7

# Install dependencies
RUN apk add --no-cache \
  bash \
  openssh \
  socat && \
  rm -rf /var/cache/apk/*

# Copy entrypoint script to container
COPY entrypoint.sh /entrypoint.sh
RUN chmod a+x /entrypoint.sh

# Setup environment variables; export SSH_AUTH_SOCK from socket directory
ENV SOCKET_DIR /.ssh-agent
ENV SSH_AUTH_SOCK ${SOCKET_DIR}/socket
ENV SSH_AUTH_PROXY_SOCK ${SOCKET_DIR}/proxy-socket

VOLUME ${SOCKET_DIR}

ENTRYPOINT ["/entrypoint.sh"]

CMD ["ssh-agent"]