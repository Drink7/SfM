#!/bin/bash

#OS: Ubuntu 16.04
#OpenMVS 

#Prepare and empty machine for building:
sudo apt-get update -qq && sudo apt-get install -qq
sudo apt-get -y install build-essential git mercurial cmake libpng-dev libjpeg-dev libtiff-dev libglu1-mesa-dev
main_path=`pwd`

mkdir -p OpenMVS && cd OpenMVS

#Eigen (Required)
hg clone https://bitbucket.org/eigen/eigen#3.2
mkdir -p eigen_build && cd eigen_build
cmake . ../eigen
make && sudo make install
cd ..

#Boost (Required)
sudo apt-get -y install libboost-iostreams-dev libboost-program-options-dev libboost-system-dev libboost-serialization-dev

#OpenCV (Required)
sudo apt-get -y install libopencv-dev

#CGAL (Required)
sudo apt-get -y install libcgal-dev libcgal-qt5-dev

#VCGLib (Required)
git clone https://github.com/cdcseacave/VCG.git vcglib

#Ceres (Required)
sudo apt-get -y install libatlas-base-dev libsuitesparse-dev
#git clone https://ceres-solver.googlesource.com/ceres-solver ceres-solver
#mkdir -p ceres_build && cd ceres_build
#cmake . ../ceres-solver/ -DMINIGLOG=ON -DBUILD_TESTING=OFF -DBUILD_EXAMPLES=OFF
#make -j2 && sudo make install
wget http://ceres-solver.org/ceres-solver-1.10.0.tar.gz
tar xvzf ceres-solver-1.10.0.tar.gz
mkdir -p ceres-build && cd ceres-build
cmake ../ceres-solver-1.10.0 -DCMAKE_C_FLAGS=-fPIC -DCMAKE_CXX_FLAGS=-fPIC -DBUILD_EXAMPLES=OFF -DBUILD_TESTING=OFF
sudo make install
cd ..

#GLFW3 (Optional)
sudo apt-get -y install freeglut3-dev libglew-dev libglfw3-dev

#OpenMVS
git clone https://github.com/cdcseacave/openMVS.git openMVS
mkdir -p openMVS_build && cd openMVS_build
#cmake . ../openMVS -DCMAKE_BUILD_TYPE=Release -DVCG_DIR="../vcglib" -DBUILD_SHARED_LIBS=ON -DOpenMVS_USE_CUDA=OFF
cmake . ../openMVS -DCMAKE_BUILD_TYPE=Release -DVCG_DIR="../vcglib" -DBUILD_SHARED_LIBS=ON 

#Install OpenMVS library (optional):
make -j4 && sudo make install


echo 'export LD_LIBRARY_PATH=/usr/local/lib/OpenMVS:$LD_LIBRARY_PATH' >> ~/.bashrc
source ~/.bashrc
