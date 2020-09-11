VERSION ?= 0.2.2
REPO_NAME = oblatespheroid/pyenv

build:
	docker build -t ${REPO_NAME}:${VERSION} .
	docker tag ${REPO_NAME}:${VERSION} ${REPO_NAME}:latest 

push:
	# Dockerhub will autobuild version numbers. After commit, run make push
	git tag v${VERSION}
	git push
	git push --tags | : # don't force overwritting tags, fail quietly

test:
	@docker run -it --name=pyenv_cont ${REPO_NAME}:latest ash -lc "pyenv versions" || docker rm pyenv_cont
	@docker run -it --name=pyenv_cont2 ${REPO_NAME}:latest ash -lc "PYENV_AUTOINSTALL=1 PYENV_VERSION=3.6.10 python --version" || docker rm pyenv_cont2
	@docker rm pyenv_cont pyenv_cont2 1>/dev/null

.PHONY: all test
