FROM jupyter/r-notebook

EXPOSE 8080
EXPOSE 8888

USER root

RUN locale-gen en_US.UTF-8
ENV LANG       en_US.UTF-8
ENV LC_ALL     en_US.UTF-8

RUN bash -c "apt-get update && \
apt-get install -y \
jags \
vowpal-wabbit \
&& rm -rf /var/lib/apt/lists/* \
"
USER jovyan

RUN bash -c "conda install \ 
-c https://conda.binstar.org/pymc pymc \
"

ADD requirements.txt /home/jovyan/work/requirements.txt
RUN bash -c "pip install --no-cache-dir -r /home/jovyan/work/requirements.txt"

#Installing pymc3 packages
RUN bash -c "conda install -y theano mkl-service pymc3"

# Installing R packages
RUN bash -c "conda install -y r-essentials r-coda r-rjags r-gtools"
