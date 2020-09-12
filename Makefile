VERSION ?= 0.2.3
REPO_NAME = oblatespheroid/pyenv
CMD = python --version

build:
	docker build -t ${REPO_NAME}:${VERSION} .
	docker tag ${REPO_NAME}:${VERSION} ${REPO_NAME}:latest 

push:
	# Dockerhub will autobuild version numbers. After commit, run make push
	git tag ${VERSION}
	git push
	git push --tags

run:
	@docker run --rm -e PYENV_AUTOINSTALL=1 ${REPO_NAME} ash -lc "${CMD}"

test:
	@docker run --rm ${REPO_NAME}:latest ash -lc "pyenv versions"
	@docker run --rm -e PYENV_AUTOINSTALL=1 ${REPO_NAME}:latest ash -lc "echo 3.6.10>.python-version && python --version"

.PHONY: all test
