
FROM c3h3/py278-openblas-scipy-base

RUN ipython profile create dark
ADD custom.css /home/pyuser/.ipython/profile_dark/static/custom/custom.css
CMD ipython notebook --no-browser --ip=0.0.0.0 --port 8888 --profile=dark



