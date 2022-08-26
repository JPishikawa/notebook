FROM registry.access.redhat.com/ubi8/python-39:latest

ARG work_dir="/src/"

WORKDIR ${work_dir}

ENV POETRY_HOME=/opt/poetry

RUN curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python && \
    cd /usr/local/bin && \
    ln -s /opt/poetry/bin/poetry && \
    poetry config virtualenvs.create false

WORKDIR ${work_dir}

RUN git clone https://github.com/JPishikawa/notebook && \
    cd ./notebook && \
    poetry install 


ENTRYPOINT ["jupyter", "lab"] 
CMD ["--ip=0.0.0.0, --NotebookApp.token='', --port=8888"] 
EXPOSE 8888

