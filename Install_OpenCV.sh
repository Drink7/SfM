#!/bin/bash

#
sudo apt-get --yes update
sudo apt-get --yes upgrade

# Build tools
sudo apt-get --yes install build-essential cmake pkg-config git

# Media IO
#sudo apt-get --yes install libjpeg-dev libtiff5-dev libjasper-dev libpng12-dev 
sudo apt-get install --yes zlib1g-dev libjpeg-dev libwebp-dev libpng-dev libtiff5-dev libjasper-dev libopenexr-dev libgdal-dev

#Video IO
#sudo apt-get --yes install libavcodec-dev libavformat-dev libswscale-dev libv4l-dev libxvidcore-dev libx264-dev
sudo apt-get install --yes libdc1394-22-dev libavcodec-dev libavformat-dev libswscale-dev libtheora-dev libvorbis-dev libxvidcore-dev libx264-dev yasm libopencore-amrnb-dev libopencore-amrwb-dev libv4l-dev libxine2-dev

# GUI
sudo apt-get --yes install libgtk2.0-dev

# Parallelism and linear algebra libraries:
#sudo apt-get --yes install libtbb-dev
sudo apt-get install --yes libtbb-dev libeigen3-dev

sudo apt-get --yes install libatlas-base-dev gfortran

# python
sudo apt-get --yes install python2.7-dev python3-dev
#sudo apt-get install --yes python-dev python-tk python-numpy python3-dev python3-tk python3-numpy
#sudo apt-get --yes install python-pip
sudo apt-get --yes install python-dev python-numpy libtbb2 libpng-dev libtiff-dev python3-numpy

# Java:
#sudo apt-get install --yes ant default-jdk

#Installation of OpenCV
mkdir SfM && cd SfM
mkdir OpenCV && cd OpenCV
git clone https://github.com/opencv/opencv.git
cd opencv && git checkout 3.2.0 && cd ..
git clone https://github.com/opencv/opencv_contrib.git
cd opencv_contrib && git checkout 3.2.0 && cd ..
cd opencv
mkdir build && cd build
cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules -D BUILD_EXAMPLES=ON ..
make -j4
sudo make install
sudo ldconfig



