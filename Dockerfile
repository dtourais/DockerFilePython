
# Utiliser l'image de base NVIDIA CUDA
FROM nvidia/cuda:11.0.3-base-ubuntu20.04

# Mettre à jour les paquets et installer les dépendances nécessaires
RUN apt-get update && apt-get install -y \
    python3.10 \
    python3-pip

# Dépendances pour OpenCV
RUN apt-get update && apt-get install ffmpeg libsm6 libxext6  -y

# Remplacer SH par BASH 
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Installer les librairies Python spécifiées
RUN pip install hydra-colorlog==1.2.0 \
                hydra-core==1.3.2 \
                hydra-optuna-sweeper==1.2.0 \
                lightning==2.0.7 \
                lightning-cloud==0.5.37 \
                lightning-utilities==0.9.0 \
                matplotlib==3.8.0 \
                numpy==1.25.2 \
                opencv-python==4.8.1.78 \
                optuna==2.10.1 \
                pandas==2.1.1 \
                Pillow==10.0.0 \
                pytest==7.4.0 \
                pyrootutils==1.0.4 \
                pytorch-lightning==2.0.7 \
                torch==2.0.1 \
                torchmetrics==1.1.0 \
                torchvision==0.15.2 \
                ultralytics==8.0.193
