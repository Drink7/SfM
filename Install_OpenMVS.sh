#!/bin/bash

#Prepare and empty machine for building:
sudo apt-get --yes update -qq && sudo apt-get --yes install -qq
sudo apt-get --yes install build-essential git mercurial cmake libpng-dev libjpeg-dev libtiff-dev libglu1-mesa-dev
cd SfM && mkdir OpenMVS && cd OpenMVS
#main_path=`pwd`

#gcc & g++ version update to 5 up (gcc5, g++5)
sudo add-apt-repository ppa:ubuntu-toolchain-r/test
sudo apt-get --yes update
sudo apt-get --yes install gcc-5 g++-5
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-5 1
sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-5 1


#Eigen (Required)
hg clone https://bitbucket.org/eigen/eigen#3.2
mkdir eigen_build && cd eigen_build
cmake . ../eigen
make && sudo make install
cd ..

#Boost (Required)
sudo apt-get --yes install libboost-iostreams-dev libboost-program-options-dev libboost-system-dev libboost-serialization-dev

#OpenCV (Required)
#sudo apt-get -y install libopencv-dev

#CGAL (Required)
sudo apt-get --yes install libcgal-dev libcgal-qt4-dev
sudo apt-get --yes install qtbase5-dev 
sudo apt-get --yes install qtdeclarative5-dev

#VCGLib (Required)
git clone https://github.com/cdcseacave/VCG.git vcglib

#Ceres (Required)
sudo apt-get -y install libatlas-base-dev libsuitesparse-dev
git clone https://ceres-solver.googlesource.com/ceres-solver ceres-solver
mkdir ceres_build && cd ceres_build
#cmake . ../ceres-solver/ -DMINIGLOG=ON -DBUILD_TESTING=OFF -DBUILD_EXAMPLES=OFF
cmake . ../ceres-solver/ -DCMAKE_C_FLAGS=-fPIC -DCMAKE_CXX_FLAGS=-fPIC -DMINIGLOG=ON -DBUILD_TESTING=OFF -DBUILD_EXAMPLES=OFF
make -j2 && sudo make install
cd ..

#GLFW3 (Optional)
sudo apt-get -y install freeglut3-dev libglew-dev
git clone https://github.com/glfw/glfw && mkdir glfw_build && cd glfw_build && cmake ../glfw && make -j4 && sudo make install && cd ..

#OpenMVS(If you want to use OpenMVS as shared library, add to the CMake command:-DBUILD_SHARED_LIBS=ON)
git clone https://github.com/cdcseacave/openMVS.git openMVS
mkdir openMVS_build && cd openMVS_build
cmake . ../openMVS -DCMAKE_BUILD_TYPE=Release -DVCG_DIR="../vcglib" -DBUILD_SHARED_LIBS=ON

#Install OpenMVS library (optional):
make -j2 && sudo make install