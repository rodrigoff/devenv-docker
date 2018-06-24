FROM rodrigoff/devenv

# azure-cli
RUN AZ_REPO=$(lsb_release -cs) && \
  echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" | tee /etc/apt/sources.list.d/azure-cli.list && \
  curl -L https://packages.microsoft.com/keys/microsoft.asc | apt-key add -

RUN apt-get install -y apt-transport-https && \
  apt-get update && \
  apt-get install azure-cli

RUN mkdir ~/.completion && \
  curl -fLo ~/.completion/az.completion https://raw.githubusercontent.com/Azure/azure-cli/dev/az.completion && \
  echo '\n\
autoload bashcompinit && bashcompinit\n\
\n\
if [ $commands[az] ]; then\n\
  source ~/.completion/az.completion\n\
fi' >> ~/.zshrc

# kubectl
RUN az aks install-cli

RUN echo '\n\
if [ $commands[kubectl] ]; then\n\
  source <(kubectl completion zsh)\n\
fi' >> ~/.zshrc
