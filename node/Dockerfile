FROM rodrigoff/devenv

# nodejs 10.x
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash && \
  apt-get install -y nodejs

# yarn 1.7.0
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update && \
  apt-get install -y yarn
