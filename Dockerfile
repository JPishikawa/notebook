FROM registry.access.redhat.com/ubi8/python-39:latest

RUN pwd && ls


ARG work_dir="/src/"

WORKDIR ${work_dir}

#ENV POETRY_HOME=/opt/poetry

RUN curl -sSL https://install.python-poetry.org | python - && \
    export PATH=$PATH:~/.local/bin/ && \
    poetry config virtualenvs.create false

RUN git clone https://github.com/JPishikawa/notebook && \
    cd ./notebook && \
    poetry install 


ENTRYPOINT ["jupyter", "lab"] 
CMD ["--ip=0.0.0.0, --NotebookApp.token='', --port=8888"] 
EXPOSE 8888

