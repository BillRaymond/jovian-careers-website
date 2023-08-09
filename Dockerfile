FROM ubuntu:22.04

# These settings prevent a timezone prompt when Python installs
ENV TZ=US/Pacific \
    DEBIAN_FRONTEND=noninteractive

# Update the apt repo
RUN apt update

# Define the version of Python to install
# For example "3.11" will get the latest version of 3.11 (ex 3.11.4)
ARG PYVER="3.11"

# Install Python (software-properties-common), Git, and Python utilities
RUN apt install -y software-properties-common && \
    add-apt-repository -y ppa:deadsnakes/ppa && \
    apt update && \
    apt install -y python$PYVER \
    python3-pip \
    git-all

# Upgrade packages to the latest version
RUN apt -y upgrade

# Update PIP (Python's package manager)
RUN python3 -m pip install --upgrade pip

# Configure git
RUN git config --global user.name "Bill.Raymond" &&\
    git config --global user.email bill.raymond@cambermast.com &&\
    git config --global init.defaultBranch main

# Set the symbolic link for Python 3
# RUN ln -s /usr/bin/python3.11 python3

# Set the specified PYVER as the default Python interpreter
RUN update-alternatives --install /usr/bin/python3 python /usr/bin/python$PYVER 1
RUN update-alternatives --set python /usr/bin/python$PYVER
RUN update-alternatives --set python /usr/bin/python$PYVER

