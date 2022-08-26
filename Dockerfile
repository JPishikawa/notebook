FROM registry.access.redhat.com/ubi8/python-39:latest


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

USER 1001

ENTRYPOINT ["jupyter", "lab"] 
CMD ["--ip=0.0.0.0, --NotebookApp.token='', --port=8888"] 
EXPOSE 8888

