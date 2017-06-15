#!bin/bash

#OS: Ubuntu 16.04
#OpenMVG

sudo apt-get -y install libpng-dev libjpeg-dev libtiff-dev libxxf86vm1 libxxf86vm-dev libxi-dev libxrandr-dev
sudo apt-get -y install graphviz

mkdir -p OpenMVG && cd OpenMVG
git clone --recursive https://github.com/openMVG/openMVG.git
mkdir -p openMVG_build
cd openMVG_build
cmake -DCMAKE_BUILD_TYPE=RELEASE -DOpenMVG_BUILD_TESTS=ON -DOpenMVG_BUILD_EXAMPLES=ON . ../openMVG/src/
make -j4
make test
sudo make install


