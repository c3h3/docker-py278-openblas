
FROM c3h3/py278-openblas-scipy-base

WORKDIR /home/pyuser
USER pyuser

RUN ipython profile create dark
RUN wget https://gist.githubusercontent.com/c3h3/74d5ce0bb3448823363e/raw/1e448eb5ae751642f374d010a830a8bcbc89a6bd/ipynb-dark-style -O /home/pyuser/.ipython/profile_dark/static/custom/custom.css

#CMD ipython notebook --no-browser --ip=0.0.0.0 --port 8888 --profile=dark



