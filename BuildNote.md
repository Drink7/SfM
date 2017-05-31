# SfM building process
先裝OpenCV再來裝OpenMVS(都是直接從git抓下來build)
環境是Ubuntu 14.04
* OpenMVS
    * https://github.com/cdcseacave/openMVS/wiki/Building
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
        
* OpenCV 3.2 
    * Platform : Ubuntu 14.04
    * Step
        * Please view my github script page
    * 使用命令查看安装版本
        * pkg-config --modversion opencv
    * Reference
        * http://blog.csdn.net/youngpan1101/article/details/58027049
        * http://docs.opencv.org/3.2.0/d7/d9f/tutorial_linux_install.html
        * https://gist.github.com/MarcWang/0547f87cf777b6576275
        * https://github.com/milq/milq/blob/master/scripts/bash/install-opencv.sh

* Other
    * 自動填入yes，免除每次都確認y/n https://superuser.com/questions/164553/automatically-answer-yes-when-using-apt-get-install

    