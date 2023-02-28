FROM nvidia/cuda:12.0.1-base-ubuntu22.04 

RUN export DEBIAN_FRONTEND=noninteractive \
  && apt-get update \
  && apt-get upgrade -y \
  && apt-get install -y \
  software-properties-common \
  tzdata locales \
  python3 python3-dev python3-pip python3-venv \
  gcc make git openssh-server curl iproute2 tshark \
  && rm -rf /var/lib/apt/lists/*

# replace SH with BASH 
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Locales gen
RUN ln -fs /usr/share/zoneinfo/Europe/Paris /etc/localtime \
  && dpkg-reconfigure --frontend noninteractive tzdata \
  && export LC_ALL="fr_FR.UTF-8" \
  && export LC_CTYPE="fr_FR.UTF-8" \
  && echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
  && echo "fr_FR.UTF-8 UTF-8" >> /etc/locale.gen \
  && locale-gen \
  && dpkg-reconfigure --frontend noninteractive locales

# SSH run folder
RUN mkdir -p /run/sshd

# create python venv
RUN mkdir -p /venv \
  && python3 -m venv /venv/

RUN echo "PATH=/venv/bin:$PATH" > /etc/profile.d/python_venv.sh

RUN /venv/bin/pip3 install --upgrade pip --no-cache-dir

# Install jupyterlab and its plotly extension
RUN /venv/bin/pip3 install --no-cache-dir\
    jupyterlab>=3 \
    ipywidgets>=7.6 \
    jupyter-dash \
    ipython \
    ipykernel \
    ptvsd \
    plotly 


# install all other required python packages
# Not adding basics python libraries, but we can import them in code directly
RUN /venv/bin/pip3 install --no-cache-dir \
    ahrs  \
    alembic  \
    argparse  \
    beautifulsoup4  \
    bokeh  \
    dash  \
    dash-bootstrap-components  \
    dash_daq  \
    datetime  \
    docopt  \
    dpkt  \
    glob2  \ 
    gpsd-py3  \
    gpxpy  \
    graphviz  \
    gunicorn  \
    gym  \
    h5py  \
    ipympl  \
    joblib  \
    kaleido  \ 
    lxml  \
    mako  \
    matplotlib  \
    numpy  \
    opencv-python  \
    openpyxl  \
    pandas  \
    pillow  \
    psutil  \
    pylint  \
    pyserial  \
    python-dateutil  \
    requests  \
    requests_html  \
    scikit-commpy  \
    scikit-learn  \
    scipy  \
    seaborn  \
    setuptools  \
    sqlalchemy  \
    tabulate  \
    tensorboardx  \
    tensorflow  \
    tifffile  \
    torch  \ 
    torchvision  \
    typing  \
    uncompyle6  \
    visdom  \
    xlrd  \
    xmltodict  
##The library installed on dLab is Glob, and not Glob2, but it seems it's very similar    
    

#Create Directories
RUN mkdir -p /data
RUN mkdir -p /experiments
RUN mkdir -p /home/dms_search
WORKDIR /home/dms_search
