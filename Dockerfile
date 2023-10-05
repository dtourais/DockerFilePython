# Utilisation de CentOS 7 comme base
FROM centos:7

# Mise à jour du système et installation des dépendances de base
RUN yum update -y && \
    yum install -y epel-release && \
    yum install -y \
    python3 python3-devel python3-pip \
    gcc make git openssh-server curl \
    which \
    && yum clean all

# Remplacer SH par BASH 
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Configuration du fuseau horaire
RUN ln -sf /usr/share/zoneinfo/Europe/Paris /etc/localtime

# Configuration des locales
RUN yum install -y glibc-all-langpacks && \
    localedef -i fr_FR -f UTF-8 fr_FR.UTF-8

ENV LC_ALL=fr_FR.UTF-8 \
    LANG=fr_FR.UTF-8 \
    LANGUAGE=fr_FR:fr

# Dossier SSH
RUN mkdir -p /run/sshd

# Création d'un environnement virtuel Python
RUN mkdir -p /venv && \
    python3 -m venv /venv/

RUN echo "PATH=/venv/bin:$PATH" > /etc/profile.d/python_venv.sh

RUN /venv/bin/pip3 install --upgrade pip --no-cache-dir

# Installation de Pyinstaller 
RUN /venv/bin/pip3 install pyinstaller --no-cache-dir

# Installation de JupyterLab et de son extension plotly
RUN /venv/bin/pip3 install --no-cache-dir \
    jupyterlab>=3 \
    ipywidgets>=7.6 \
    jupyter-dash==0.4.2 \
    ipython==8.11.0 \
    ipykernel==6.21.2 \
    ptvsd==4.3.2 \
    plotly==5.13.1 

# Installation des autres paquets Python requis
RUN /venv/bin/pip3 install --no-cache-dir \
    ahrs==0.3.1 \
    alembic==1.10.1 \
    argparse==1.1 \
    beautifulsoup4==4.11.2 \
    bokeh==3.0.3 \
    dash==2.8.1 \
    dash-bootstrap-components \
    dash_daq==0.5.0 \
    datetime \
    docopt==0.6.2 \
    dpkt==1.9.8 \
    glob2==0.7 \
    gpsd-py3 \
    gpxpy==1.5.0 \
    graphviz==0.20.1 \
    gunicorn==20.1.0 \
    gym==0.26.2 \
    h5py==3.8.0 \
    ipympl==0.9.3 \
    joblib==1.2.0 \
    kaleido==0.2.1 \
    lxml==4.9.2 \
    mako==1.2.4 \
    matplotlib \
    numpy==1.24.2 \
    opencv-python \
    openpyxl==3.1.1 \
    pandas==1.5.3 \
    pillow \
    psutil==5.9.4 \
    pylint==2.16.4 \
    pyserial \
    python-dateutil \
    requests==2.28.2 \
    requests_html \
    scikit-commpy \
    scikit-learn \
    scipy==1.10.1 \
    seaborn==0.12.2 \
    setuptools==44.0.0 \
    sqlalchemy==2.0.5.post1 \
    tabulate==0.9.0 \
    tensorboard==2.12.0 \
    tifffile==2023.2.28 \
    torch==1.13.1 \
    torchvision==0.14.1 \
    uncompyle6==3.9.0 \
    visdom==0.2.4 \
    xlrd==2.0.1 \
    xmltodict==0.13.0 \
    scikit-optimize \
    optuna \
    hyperopt \
    bashplotlib \
    albumentations \
    timm \
    lightgbm \
    ultralytics \
    grad-cam \
    optuna-distributed \
    folium \
    plotly \
    kaleido \
    geopandas \
    PyQt5

# Création des répertoires
RUN mkdir -p /data
RUN mkdir -p /experiments
RUN mkdir -p /home/
WORKDIR /home/
