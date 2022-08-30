#FROM registry.access.redhat.com/ubi8/python-39:latest
FROM quay.io/thoth-station/s2i-minimal-notebook:latest

ARG work_dir="/src/"

WORKDIR ${work_dir}

#ENV POETRY_HOME=/opt/poetry

RUN curl -sSL https://install.python-poetry.org | python - && \
    export PATH=$PATH:~/.local/bin/ && \
    poetry config virtualenvs.create false

USER root

RUN git clone https://github.com/JPishikawa/notebook && \
    cd ./notebook && \
    poetry install

RUN chown default -R /src/notebook/ && \
    chown default -R /opt/app-root/src/
    #ls -la /opt/app-route

USER 1001

ENTRYPOINT ["jupyter", "lab"] 
#CMD ["--ip=0.0.0.0"]
EXPOSE 8888

