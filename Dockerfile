
FROM debian:jessie

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get -y install git-core build-essential gfortran
RUN apt-get -y install sudo
RUN apt-get -y install make cmake
RUN apt-get -y install libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev
RUN apt-get -y install wget curl llvm
RUN apt-get -y install vim

RUN mkdir /tmp/openblas_build
RUN cd /tmp/openblas_build/ && wget https://github.com/xianyi/OpenBLAS/archive/v0.2.12.tar.gz && tar xfzv v0.2.12.tar.gz
RUN cd /tmp/openblas_build/OpenBLAS-0.2.12/ &&  make DYNAMIC_ARCH=1 NO_AFFINITY=1 NUM_THREADS=32 && make install && ldconfig

RUN cd /tmp && rm -rf openblas_build/

ENV LD_LIBRARY_PATH /opt/OpenBLAS/lib/

RUN useradd -m pyuser
RUN echo 'pyuser ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

WORKDIR /home/pyuser
USER pyuser

ENV HOME /home/pyuser
ENV PYENVPATH $HOME/.pyenv
ENV PATH $PYENVPATH/shims:$PYENVPATH/bin:$PATH

RUN curl -L https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer | bash

RUN echo 'eval "$(pyenv init -)"' >  ~/.bashrc

RUN pyenv install 2.7.8
RUN pyenv global 2.7.8

RUN pip install ipython cython nose pyzmq jinja2 tornado

RUN mkdir ipynbs

RUN git clone https://github.com/numpy/numpy.git
ADD numpy-site.cfg /home/pyuser/numpy/site.cfg 
RUN cd numpy && git checkout v1.8.2 && python setup.py config && python setup.py build && python setup.py install

#RUN wget https://gist.github.com/raw/3842524/df01f7fa9d849bec353d6ab03eae0c1ee68f1538/test_numpy.py
#RUN OMP_NUM_THREADS=1 python test_numpy.py
#RUN OMP_NUM_THREADS=12 python test_numpy.py

RUN rm -rf /home/pyuser/numpy

RUN git clone https://github.com/scipy/scipy.git
ADD scipy-site.cfg /home/pyuser/scipy/site.cfg
RUN cd scipy && git checkout v0.14.0 && python setup.py config && python setup.py build && python setup.py install
RUN rm -rf /home/pyuser/scipy



