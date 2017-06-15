#!/bin/bash
# Revised from https://github.com/paulinus/opensfm-docker-base/blob/master/Dockerfile

# Go into the directory under SfM
cd SfM && mkdir -p OpenSfM && cd OpenSfM

#Step1
# Install apt-getable dependencies
sudo apt-get update
sudo apt-get --yes install cmake libatlas-base-dev libboost-python-dev libeigen3-dev libgoogle-glog-dev python-dev python-numpy python-opencv python-pip python-pyexiv2 python-pyproj python-scipy python-yaml wget

#Step2
git clone https://github.com/mapillary/OpenSfM.git
cd OpenSfM
sudo pip install -r requirements.txt
sudo python setup.py build
cd ..

#Step3
# Install opengv from source
git clone https://github.com/paulinus/opengv.git
mkdir -p opengv_build && cd opengv_build
cmake ../opengv -DBUILD_TESTS=OFF -DBUILD_PYTHON=ON && make -j2 && sudo make install
cd ..

# Install Ceres from source (Done at OpenMVS.sh)
sudo apt-get -y install libatlas-base-dev libsuitesparse-dev libgoogle-glog-dev
# google-glog + gflags
#git clone https://ceres-solver.googlesource.com/ceres-solver ceres-solver
#mkdir -p ceres_build && cd ceres_build
#cmake . ../ceres-solver/ -DMINIGLOG=ON -DBUILD_TESTING=OFF -DBUILD_EXAMPLES=OFF
#cmake . ../ceres-solver/ -DCMAKE_C_FLAGS=-fPIC -DCMAKE_CXX_FLAGS=-fPIC -DMINIGLOG=ON -DBUILD_TESTING=OFF -DBUILD_EXAMPLES=OFF
#make -j2 && sudo make install
wget http://ceres-solver.org/ceres-solver-1.10.0.tar.gz
tar xvzf ceres-solver-1.10.0.tar.gz
cd ceres-solver-1.10.0
mkdir -p build && cd build
cmake .. -DCMAKE_C_FLAGS=-fPIC -DCMAKE_CXX_FLAGS=-fPIC -DMINIGLOG=ON -DBUILD_EXAMPLES=OFF -DBUILD_TESTING=OFF
sudo make install
cd ..
