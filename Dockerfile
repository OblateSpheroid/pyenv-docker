FROM alpine:latest

RUN apk add --no-cache bash bzip2-dev curl gcc git libc-dev make openssl-dev readline-dev sqlite-dev zlib-dev

RUN adduser -D pyenv
USER pyenv

RUN echo -e '\n\
export PYENV_ROOT="$HOME/.pyenv"\n\
export PATH="$PYENV_ROOT/bin:$PYENV_ROOT/shims:$PATH"\n\
eval "$(pyenv init -)"\n\
eval "$(pyenv virtualenv-init -)"\n' >> $HOME/.profile

RUN curl https://pyenv.run | bash
RUN cd $HOME/.pyenv && \
git remote add new https://github.com/oblatespheroid/pyenv.git && \
git fetch --all && \
git reset --hard new/master

RUN source $HOME/.profile && \
git clone https://github.com/momo-lab/xxenv-latest.git $HOME/.pyenv/plugins/xxenv-latest && \
sed -i.bkup 's/--version-sort/-V/g' $HOME/.pyenv/plugins/xxenv-latest/bin/xxenv-latest && \
pyenv latest install 3 && \
pyenv latest global 3

WORKDIR /home/pyenv
CMD ["ash", "-l"] 
