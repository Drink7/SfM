# SfM building process
先裝OpenCV再來裝OpenMVG(都是直接從git抓下來build)，緊接著裝OpenMVS後先做一次測試
最後是OpenSfM
環境是Ubuntu 14.04(16.04也測試過，但安裝步驟稍有不同)
* OpenMVS
    * 官網: https://github.com/cdcseacave/openMVS
    * 安裝步驟:https://github.com/cdcseacave/openMVS/wiki/Building
    * CGAL libcgal-qt5-dev(14.04無法裝，14.04是用qt4)
        * 可能的解決方式
        * sudo apt-get install qtbase5-dev
        * sudo apt-get install qtdeclarative5-dev
        * Reference:
            * http://www.cgal.org/download/linux.html
            * https://askubuntu.com/questions/508503/whats-the-development-package-for-qt5-in-14-04
    * Unable to locate package GLFW-3 on Ubuntu 14.04
        * The RandR library and headers were not found (on Ubuntu) <-若遇到此問題先解決
            * https://github.com/openMVG/openMVG/issues/85
        * Reference: https://github.com/filipwasil/fillwave/issues/58
        * git clone https://github.com/glfw/glfw && mkdir build && cd build && cmake ../glfw && make -j4 && sudo make install
    * OpenCV的問題
        * By not providing "FindOpenCV.cmake" in CMAKE_MODULE_PATH this project has asked CMake to find a package configuration file provided by "OpenCV", but CMake did not find one.
    *  VCG required but not found
        *  https://github.com/cdcseacave/openMVS/issues/46
        *  https://github.com/cdcseacave/openMVS/issues/86
    *  c++ internal compiler error killed (program cc1plus)
        *  主要原因大体上是因为内存不足
        *  解決方式:
        增加虛擬機記憶體
        *  http://blog.csdn.net/bxd1314/article/details/47338391
    *  main_path=`pwd`
        *  https://stackoverflow.com/questions/2314750/how-to-assign-the-output-of-a-bash-command-to-a-variable
    *  [apps/Viewer/CMakeFiles/Viewer.dir/all] Error 2 (目前卡這，92%)
        *  主因:FastDelegateCPP11.h:48:5: error
        *  https://github.com/cdcseacave/openMVS/issues/205
        *  https://stackoverflow.com/questions/10851247/how-to-activate-c-11-in-cmake
        *  https://stackoverflow.com/questions/8403722/installing-c11-compiler-on-ubuntu
        *  https://github.com/cdcseacave/openMVS/blob/master/libs/Common/FastDelegateCPP11.h
        *  解決方式，gcc、g++都升級到5以上，就可以解決 (0531)
            *  https://gist.github.com/beci/2a2091f282042ed20cda
    *  subprocess.py oserror errno 2 no such file or directory(0614)
        *  路徑錯誤而已
        *  解決方式:
        *  修正openMVS和openMVG的路徑以及openMVG會用到的sensor camera位置
    *  The input SfM_Data file sfm_data.bin cannot be read(0614)
        *  解決方式:
        因為前面步驟沒有成功產生sfm_data.bin，須確保openMVG那部分步驟正確

    * error while loading shared libraries: libMVS.so
        * https://github.com/cdcseacave/openMVS/issues/190
        * 解決方式:
        export LD_LIBRARY_PATH=/usr/local/lib/OpenMVS:$LD_LIBRARY_PATH
       
* OpenCV 3.2 
    * Platform : Ubuntu 14.04
    * Step
        * 主要參考: https://github.com/milq/milq/blob/master/scripts/bash/install-opencv.sh
    * 使用命令查看安装版本
        * pkg-config --modversion opencv
    * Reference
        * http://blog.csdn.net/youngpan1101/article/details/58027049
        * http://docs.opencv.org/3.2.0/d7/d9f/tutorial_linux_install.html
        * https://gist.github.com/MarcWang/0547f87cf777b6576275
        * https://github.com/milq/milq/blob/master/scripts/bash/install-opencv.sh
* OpenSfM
    * 官網:https://github.com/mapillary/OpenSfM
    * undefined symbol: cs_di_chol(0614)
        * 解決方式: 
        務必按照安裝步驟來做
        * Step 1: Install OpenCV, Boost Python, NumPy, SciPy using apt-get
        * Step 2: Install python requirements using pip
        * Step 3: Clone, build and install OpenGV following the receipt in the Dockerfile
        * Step 4: Build and Install the Ceres solver from its source using the -fPIC compilation flag.
        * 
* OpenMVG
    * 官網 : https://github.com/openMVG/openMVG
    * 安裝: https://raw.githubusercontent.com/openMVG/openMVG/master/BUILD
    
* Other
    * 自動填入yes，免除每次都確認y/n https://superuser.com/questions/164553/automatically-answer-yes-when-using-apt-get-install
    * OpenSfM Reference
        * https://github.com/mapillary/OpenSfM
        * https://github.com/paulinus/opensfm-docker-base/blob/master/Dockerfile
        * https://blog.longwin.com.tw/2012/05/apt-clean-autoclean-diff-2012/
        * https://stackoverflow.com/questions/11616835/r-command-not-found-bashrc-bash-profile

* Install step
    * Install OpenCV
    * Install OpenMVG
    * Install OpenMVS
    * Install OpenSfM
* Test
    * OpenMVS
        * Sample  https://github.com/cdcseacave/openMVS/wiki/Usage
        要下載下面兩個，一個是openMVS_sample的資料夾，第二個是dataset
        * (1) https://github.com/cdcseacave/openMVS_sample
        * (2) https://github.com/openMVG/ImageDataset_SceauxCastle
        * 記得要改MvgMvs_Pipeline.py
            * OPENMVG_BIN = "D:/Pro/OpenMVG/install/bin/"
OPENMVS_BIN = "D:/Pro/OpenMVS/install/bin/"
CAMERA_SENSOR_WIDTH_DIRECTORY
這三個位置
        * 改成
            * OPENMVG_BIN = "/usr/local/bin/"
OPENMVS_BIN = "/usr/local/bin/OpenMVS"
CAMERA_SENSOR_WIDTH_DIRECTORY = "/usr/local/share/openMVG
        * 記得input/output路徑要給對
        * output會在 mvs資料夾下
    * OpenSfM
        * https://media.readthedocs.org/pdf/opensfm/latest/opensfm.pdf
        * bin/opensfm_run_all data/berlin
        * python -m SimpleHTTPServer
        * http://localhost:8000/viewer/reconstruction.html#file=/data/berlin/reconstruction.meshed.json