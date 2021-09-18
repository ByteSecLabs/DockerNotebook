FROM python:3

WORKDIR /usr/src/app

RUN apt-get install wget -y
RUN wget -qO - http://packages.confluent.io/deb/3.1/archive.key | apt-key add -
RUN echo "\ndeb [arch=amd64] http://packages.confluent.io/deb/3.1 stable main\n" >> /etc/apt/sources.list
RUN apt-get update
RUN apt-get install -y python3-wheel librdkafka-dev
RUN apt-get install -y build-essential python3 python3-pip python3-dev
RUN pip3 install --upgrade pip
RUN apt autoremove -y && apt clean -y

RUN pip3 install jupyter
RUN pip3 install matplotlib pandas requests kaleido plotly

RUN jupyter notebook --generate-config
RUN python3 -c "from notebook.auth.security import set_password; set_password('changeme!', '/root/.jupyter/jupyter_notebook_config.json')"

CMD ["jupyter", "notebook", "--port=8888", "--no-browser", "--ip=0.0.0.0", "--allow-root"]
