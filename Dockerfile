
FROM c3h3/pyenv-openblas-base

ENV DEBIAN_FRONTEND noninteractive

WORKDIR /home/pyuser
USER pyuser

RUN pyenv install 2.7.8
RUN pyenv global 2.7.8


