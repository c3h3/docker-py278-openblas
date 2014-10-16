
FROM c3h3/py278-openblas-scipy-base

RUN ipython profile create dark
RUN sudo chown pyuser /home/pyuser/.ipython

ADD custom.css /home/pyuser/.ipython/profile_default/static/custom/custom.css

#CMD ipython notebook --no-browser --ip=0.0.0.0 --port 8888



