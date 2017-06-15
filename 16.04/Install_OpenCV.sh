#!/bin/bash

#OS: Ubuntu 16.04
#OpenCV: 3.2.0

sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get -y install build-essential cmake pkg-config
sudo apt-get -y install libjpeg8-dev libtiff5-dev libjasper-dev libpng12-dev
sudo apt-get -y install libavcodec-dev libavformat-dev libswscale-dev libv4l-dev
sudo apt-get -y install libxvidcore-dev libx264-dev
sudo apt-get -y install libgtk-3-dev
sudo apt-get -y install libatlas-base-dev gfortran
sudo apt-get -y install libopencv-dev build-essential cmake git libgtk2.0-dev pkg-config python-dev python-numpy libdc1394-22 libdc1394-22-dev libjpeg-dev libpng12-dev libjasper-dev libavcodec-dev libavformat-dev libswscale-dev libgstreamer0.10-dev libgstreamer-plugins-base0.10-dev libv4l-dev libtbb-dev libqt4-dev libfaac-dev libmp3lame-dev libopencore-amrnb-dev libopencore-amrwb-dev libtheora-dev libvorbis-dev libxvidcore-dev x264 v4l-utils unzip
sudo apt-get -y install python2.7-dev python3.5-dev
wget https://github.com/opencv/opencv/archive/3.2.0.zip -O opencv-3.2.0.zip
unzip opencv-3.2.0.zip
cd opencv-3.2.0
mkdir -p build && cd build
#cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local -D BUILD_NEW_PYTHON_SUPPORT=ON -D BUILD_EXAMPLES=ON -D WITH_CUDA=OFF ..
cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local -D BUILD_NEW_PYTHON_SUPPORT=ON -D BUILD_EXAMPLES=ON ..
make -j4
sudo make install


echo 'export PYTHONPATH=$PYTHONPATH:/usr/local/lib/python2.7/site-packages' >> ~/.bashrc
source ~/.bashrc
