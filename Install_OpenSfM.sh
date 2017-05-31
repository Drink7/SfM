#!/bin/bash
# Revised from https://github.com/paulinus/opensfm-docker-base/blob/master/Dockerfile

# Go into the directory under SfM
cd SfM && mkdir -p OpenGV && cd OpenGV

# Install apt-getable dependencies
sudo apt-get update && sudo apt-get --yes install cmake libatlas-base-dev libboost-python-dev libeigen3-dev libgoogle-glog-dev python-dev python-numpy python-opencv python-pip python-pyexiv2 python-pyproj python-scipy python-yaml wget
git clone https://github.com/paulinus/opengv.git

# Install Ceres from source (Done at OpenMVS.sh)
mkdir -p opengv_build && cd opengv_build

# Install opengv from source
cmake ../opengv -DBUILD_TESTS=OFF -DBUILD_PYTHON=ON && make -j2 && sudo make install
cd ..
