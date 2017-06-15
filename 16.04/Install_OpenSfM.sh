#!/bin/bash

#OS: Ubuntu 16.04
#OpenSfM

mkdir -p OpenSfM && cd OpenSfM
git clone https://github.com/mapillary/OpenSfM.git
sudo apt-get -y install build-essential cmake git libatlas-base-dev libboost-python-dev libeigen3-dev libgoogle-glog-dev libsuitesparse-dev python-dev python-numpy python-opencv python-pip python-pyexiv2 python-pyproj python-scipy python-yaml wget

cd OpenSfM
pip install -r requirements.txt
python setup.py build
cd ..

mkdir -p OpenGV && cd OpenGV
git clone https://github.com/paulinus/opengv.git
mkdir -p opengv_build && cd opengv_build
cmake ../opengv -DBUILD_TESTS=OFF -DBUILD_PYTHON=ON
make -j2 && sudo make install

mkdir -p ceres && cd ceres
wget http://ceres-solver.org/ceres-solver-1.10.0.tar.gz
tar xvzf ceres-solver-1.10.0.tar.gz
cd ceres-solver-1.10.0/
mkdir -p build && cd build
cmake .. -DCMAKE_C_FLAGS=-fPIC -DCMAKE_CXX_FLAGS=-fPIC -DBUILD_EXAMPLES=OFF -DBUILD_TESTING=OFF
sudo make install
