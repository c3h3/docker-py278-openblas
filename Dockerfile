
FROM c3h3/pyenv-openblas-base

ENV LD_LIBRARY_PATH /opt/OpenBLAS/lib/

RUN pyenv install 2.7.8
RUN pyenv global 2.7.8


