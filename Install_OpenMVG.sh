#!bin/bash

# Setup the required external library.
sudo apt-get --yes install libpng-dev libjpeg-dev libtiff-dev libxxf86vm1 libxxf86vm-dev libxi-dev libxrandr-dev
# If you want see the view graph svg logs
sudo apt-get --yes install graphviz

# cd into the dir
cd SfM && mkdir -p OpenMVG && cd OpenMVG
# Get the source
git clone --recursive https://github.com/openMVG/openMVG.git
mkdir -p openMVG_Build && cd openMVG_Build

# If you want enable unit tests and examples to the build:
cmake -DCMAKE_BUILD_TYPE=RELEASE -DOpenMVG_BUILD_TESTS=ON -DOpenMVG_BUILD_EXAMPLES=ON . ../openMVG/src/

make -j2 && make test && sudo make install

