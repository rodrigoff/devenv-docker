FROM rodrigoff/devenv

RUN sudo rpm -Uvh https://packages.microsoft.com/config/rhel/7/packages-microsoft-prod.rpm && \
  sudo yum update && \
  sudo yum install -y libunwind libicu && \
  sudo yum install -y dotnet-sdk-2.1.200
