## How to run

```
docker run --rm --it rodrigoff/devenv-azure
```

### Keeping az-cli and kubectl state

Map the `/root/.azure` and `/root/.kube` folders to a volume or bind mount:

```
docker run --rm --it -v <your local azure folder>:/root/.azure -v <your local kube folder>:/root/.kube rodrigoff/devenv-azure
```