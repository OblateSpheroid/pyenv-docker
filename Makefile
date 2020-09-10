VERSION ?= 0.1.1

all:
	docker build -t pyenv:${VERSION} .
	docker tag pyenv:${VERSION} pyenv:latest 

test:
	@docker run -it --name=pyenv_cont pyenv ash -lc "pyenv versions" || docker rm pyenv_cont
	@docker rm pyenv_cont 1>/dev/null

.PHONY: all test
