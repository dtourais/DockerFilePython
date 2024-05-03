FROM nvidia/cuda:11.0.3-base-ubuntu20.04 

RUN export DEBIAN_FRONTEND=noninteractive \
  && apt-get update \
  && apt-get upgrade -y \
  && apt-get install -y \
  software-properties-common \
  tzdata locales \
  python3 python3-dev python3-pip python3-venv \
  gcc make git openssh-server curl iproute2 tshark \
  && rm -rf /var/lib/apt/lists/*

#dependences pour OpenCv
RUN apt-get update && apt-get install ffmpeg libsm6 libxext6  -y


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

# Install Pyinstaller 
RUN /venv/bin/pip3 install pyinstaller --no-cache-dir

# Install jupyterlab and its plotly extension
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
	lightning==2.2.0.post0  \
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
	
##The previous lib was Glob, and not Glob2, but it seems it's very similar    

#Create Directories
RUN mkdir -p /data
RUN mkdir -p /experiments
RUN mkdir -p /home/
WORKDIR /home/
