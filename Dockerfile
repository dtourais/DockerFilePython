FROM nvidia/cuda:11.0.3-base-ubuntu20.04 

# Ajout du PPA pour Python 3.10
RUN export DEBIAN_FRONTEND=noninteractive \
  && apt-get update \
  && apt-get upgrade -y \
  && apt-get install -y software-properties-common \
  && add-apt-repository ppa:deadsnakes/ppa \
  && apt-get update

# Installation de Python 3.10 et des paquets nécessaires
RUN apt-get install -y \
  tzdata locales \
  python3.10 python3.10-dev python3.10-venv python3-pip \
  gcc make git openssh-server curl iproute2 tshark \
  && rm -rf /var/lib/apt/lists/*

# Dépendances pour OpenCV
RUN apt-get update && apt-get install ffmpeg libsm6 libxext6  -y

# Remplacer SH par BASH 
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Configuration des locales
RUN ln -fs /usr/share/zoneinfo/Europe/Paris /etc/localtime \
  && dpkg-reconfigure --frontend noninteractive tzdata \
  && export LC_ALL="fr_FR.UTF-8" \
  && export LC_CTYPE="fr_FR.UTF-8" \
  && echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
  && echo "fr_FR.UTF-8 UTF-8" >> /etc/locale.gen \
  && locale-gen \
  && dpkg-reconfigure --frontend noninteractive locales

# Configuration de SSH
RUN mkdir -p /run/sshd

# Création de l'environnement virtuel Python
RUN mkdir -p /venv \
  && python3.10 -m venv /venv/

# Configuration de l'environnement virtuel Python
RUN echo "PATH=/venv/bin:$PATH" > /etc/profile.d/python_venv.sh

# Mise à jour de pip dans l'environnement virtuel
RUN /venv/bin/pip3 install --upgrade pip --no-cache-dir

# Installation de Pyinstaller 
RUN /venv/bin/pip3 install pyinstaller --no-cache-dir

# Installation de JupyterLab et des extensions
RUN /venv/bin/pip3 install --no-cache-dir\
    jupyterlab>=3 \
    ipywidgets>=7.6 \
    jupyter-dash==0.4.2 \
    ipython==8.11.0 \
    ipykernel==6.21.2 \
    ptvsd==4.3.2 \
    plotly==5.13.1


# install all other required python packages
# Not adding basics python libraries, but we can import them in code directly
RUN /venv/bin/pip3 install --no-cache-dir \
    ahrs==0.3.1  \
    alembic==1.10.1  \
    argparse==1.1  \
    beautifulsoup4==4.11.2  \
    bokeh==3.0.3  \
    dash==2.8.1  \
    dash-bootstrap-components  \
    dash_daq==0.5.0  \
    datetime  \
    docopt==0.6.2  \
    dpkt==1.9.8  \
    glob2==0.7  \ 
    gpsd-py3  \
    gpxpy==1.5.0 \
    graphviz==0.20.1  \
    gunicorn==20.1.0  \
    gym==0.26.2  \
    h5py==3.8.0  \
    ipympl==0.9.3  \
    joblib==1.2.0  \
    kaleido==0.2.1  \ 
    lxml==4.9.2 \
    mako==1.2.4  \
    matplotlib==3.8.0  \ 
    numpy==1.25.2  \  
    opencv-python==4.8.1.78  \ 
    openpyxl==3.1.1  \
    pandas==2.1.1  \ 
    pillow==10.0.0  \
    psutil==5.9.4  \
    pylint==2.16.4  \
    pyserial  \
    python-dateutil  \
    requests==2.28.2  \
    requests_html  \
    scikit-commpy  \
    scikit-learn  \
    scipy==1.10.1  \
    seaborn==0.12.2  \
    setuptools==44.0.0  \
    sqlalchemy==2.0.5.post1  \
    tabulate==0.9.0  \
    tensorboard==2.12.0 \
    tifffile==2023.2.28  \
    torch==2.0.1  \
    torchvision==0.15.2  \
    uncompyle6==3.9.0  \
    visdom==0.2.4  \
    xlrd==2.0.1  \
    xmltodict==0.13.0 \
    scikit-optimize \
    optuna==2.10.1  \ 
    hyperopt \
    bashplotlib \
    albumentations \
    timm \
    lightgbm \
    ultralytics==8.0.193  \
    grad-cam \
    optuna-distributed \
    folium \
    plotly \
    kaleido \
    geopandas \
    PyQt5 \
    hydra-colorlog==1.2.0 \
    hydra-core==1.3.2 \
    hydra-optuna-sweeper==1.2.0 \
    lightning==2.0.7 \
    lightning-cloud==0.5.37 \
    lightning-utilities==0.9.0 \
    nvidia-cublas-cu11==11.10.3.66 \
    nvidia-cuda-cupti-cu11==11.7.101 \
    nvidia-cuda-nvrtc-cu11==11.7.99 \
    nvidia-cuda-runtime-cu11==11.7.99 \
    nvidia-cudnn-cu11==8.5.0.96 \
    nvidia-cufft-cu11==10.9.0.58 \
    nvidia-curand-cu11==10.2.10.91 \
    nvidia-cusolver-cu11==11.4.0.1 \
    nvidia-cusparse-cu11==11.7.4.91 \
    nvidia-nccl-cu11==2.14.3 \
    nvidia-nvtx-cu11==11.7.91 \
    pytest==7.4.0 \
    pyrootutils==1.0.4 \
    pytorch-lightning==2.0.7 \
    torchmetrics==1.1.0
    

#Create Directories
RUN mkdir -p /data
RUN mkdir -p /experiments
RUN mkdir -p /home/
WORKDIR /home/
