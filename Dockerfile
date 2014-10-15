
FROM c3h3/pyenv-openblas-base

ENV LD_LIBRARY_PATH /opt/OpenBLAS/lib/

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



