FROM rodrigoff/rodrigoff

RUN wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.asc.gpg && \
  sudo mv microsoft.asc.gpg /etc/apt/trusted.gpg.d/  && \
  wget -q https://packages.microsoft.com/config/debian/9/prod.list  && \
  sudo mv prod.list /etc/apt/sources.list.d/microsoft-prod.list

RUN sudo apt-get update && \
  sudo apt-get install dotnet-sdk-2.1.200