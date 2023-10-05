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
    ipython==7.16.3\
    ipykernel==5.5.6 \
    ptvsd==4.3.2 \
    plotly==5.13.1 

# Installation des autres paquets Python requis
RUN /venv/bin/pip3 install --no-cache-dir \
    PyQt5 \
    matplotlib \
    folium
    


# Création des répertoires
RUN mkdir -p /data
RUN mkdir -p /experiments
RUN mkdir -p /home/
WORKDIR /home/
