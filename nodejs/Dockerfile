FROM rodrigoff/devenv

RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash

RUN echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.zshrc && \
  echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> ~/.zshrc && \
  echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"' >> ~/.zshrc

RUN /bin/bash -l -c "nvm install node && nvm use node && nvm cache clear"
