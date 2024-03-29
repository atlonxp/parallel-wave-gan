FROM nvidia/cuda:11.0-cudnn8-devel-ubuntu18.04
LABEL maintainer="siwazaki@nefrock.com"

ENV LC_ALL "C.UTF-8"
ENV LANG "C.UTF-8"
# For tzdata dependent libs
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update
RUN apt install -y --no-install-recommends \
    build-essential \
    cmake \
    git \
    zip \
    wget \
    openssl \
    file \
    curl \
    zlib1g-dev \
    libsm-dev \
    libglib2.0-dev \
    libxrender-dev \
    libxext-dev \
    ca-certificates \
    python3-dev \
    python3-pip \
    python3-setuptools \
    libssl-dev \
    libsndfile1-dev \
    emacs

RUN apt install -y --no-install-recommends sox jq
RUN rm -rf /var/lib/apt/lists/*

WORKDIR /opt/initialization
RUN pip3 install --upgrade pip
ADD requirements.txt requirements.txt
RUN pip3 install -r requirements.txt
ADD requirements-ext.txt requirements-ext.txt
RUN pip3 install -r requirements-ext.txt
RUN mkdir -p /root/.jupyter
ADD jupyter_notebook_config.py /root/.jupyter/

WORKDIR /workspace
