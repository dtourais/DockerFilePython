FROM python:3.10-buster as python-base

ENV DEBIAN_FRONTEND=noninteractive
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
ENV TZ=Europe/Paris

RUN echo 'tzdata tzdata/Areas select Europe' | debconf-set-selections
RUN echo 'tzdata tzdata/Zones/Europe select Paris' | debconf-set-selections

RUN python -m venv /venv
ENV PATH="/venv/bin:$PATH"

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    libffi-dev \
    libssl-dev \
    python3-dev \
    libyaml-dev

RUN pip install --upgrade pip setuptools wheel

RUN pip install "cython<3.0"

RUN pip install --upgrade pip && \
    pip install --no-cache-dir Flask Folium haversine jupyterlab ipywidgets jupyter-dash \
    ipython ipykernel ptvsd psycopg2-binary tensorflow keras flask flask-restful flask-cors \
    xgboost ahrs alembic argparse beautifulsoup4 dash dash-bootstrap-components \
    dash_daq datetime docopt dpkt glob2 gpsd-py3 gpxpy graphviz gunicorn gym ipympl \
    joblib kaleido lxml mako opencv-python openpyxl psutil \
    pylint pyserial python-dateutil requests requests_html scikit-commpy scikit-learn \
    seaborn sqlalchemy tabulate tifffile uncompyle6 \
    visdom xlrd xmltodict scikit-optimize optuna hyperopt bashplotlib albumentations timm \
    lightgbm ultralytics grad-cam optuna-distributed kaleido geopandas gunicorn transformers \
    datasets torchtext torchaudio \
	colorlog==6.8.2  \
	h5py==3.10.0  \
	packaging==23.2  \
	Pillow==10.2.0  \
	pre-commit  \
	progressbar==2.5  \
	pyrootutils==1.0.4  \
	protobuf==4.25.3  \
	pytest==8.1.0  \
	rich==13.7.1  \
	rootutils==1.0.7  \
	setuptools==69.1.1  \
	sh==2.0.6  \
	tqdm==4.66.2  \
	cupy==13.0.0  \
	matplotlib==3.8.3  \
	numpy==1.26.4  \
	opencv_python==4.8.1.78  \
	pandas==2.2.1  \
	scikit-image==0.22.0  \
	scipy==1.12.0  \
	lightning==2.2.4  \
	onnxruntime==1.17.1  \
	tensorboard==2.15.2  \
	thop==0.1.1.post2209072238  \
	torch==2.2.1  \
	torchmetrics==1.3.1  \
	torchvision==0.17.1  \
	hydra-core==1.3.2  \
	hydra-colorlog==1.2.0  \
	hydra-optuna-sweeper==1.2.0  \
	omegaconf==2.3.0  \
	argparse>=1.4.0  \
	progressbar2>=4.2.0
	

FROM nvidia/cuda:11.0.3-base-ubuntu20.04 as cuda-base

COPY --from=python-base /venv /venv
ENV PATH="/venv/bin:$PATH"

RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    software-properties-common tzdata locales gcc make git openssh-server curl iproute2 tshark \
    ffmpeg libsm6 libxext6 && \
    rm -rf /var/lib/apt/lists/* && \
    rm /bin/sh && ln -s /bin/bash /bin/sh

RUN ln -fs /usr/share/zoneinfo/Europe/Paris /etc/localtime \
  && dpkg-reconfigure --frontend noninteractive tzdata \
  && export LC_ALL="fr_FR.UTF-8" \
  && export LC_CTYPE="fr_FR.UTF-8" \
  && echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
  && echo "fr_FR.UTF-8 UTF-8" >> /etc/locale.gen \
  && locale-gen \
  && dpkg-reconfigure --frontend noninteractive locales

RUN mkdir -p /run/sshd

RUN mkdir -p /data /experiments /home
WORKDIR /home
