This builds a minimal Docker image of **pyenv** based off the fork at [OblateSpheroid/pyenv](https://github.com/OblateSpheroid/pyenv).
This fork has the "auto-install" option for when a Python version is referenced but not installed. The default behavior is to fail in this scenario.

### Build
To build a local image, run `make build`, or to set a new version (e.g., `1.x.x`), `make build VERSION=1.x.x`.

Images are automatically built in the [Docker Hub repo](https://hub.docker.com/repository/docker/oblatespheroid/pyenv)
for this image when a new version tag is pushed. The post build hook ensures that the `latest` tag in that repo always matches the
the most recently auto-built version.

To pull the most recent image: `docker push oblatespheroid/pyenv`

### Usage
A Docker container launched from this image can run any Python command while specifying a version of Python.

This will download and install Python 3.6.10, then call the newly installed Python to print its version:
```
docker run --rm oblatespheroid/pyenv ash -lc "echo 3.6.10>.python-version && PYENV_AUTOINSTALL=1 python --version"
```
or from this folder, simply:
```
make run CMD="echo 3.6.10>.python-version && python --version"
```
