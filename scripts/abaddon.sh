#!/bin/sh

doas pkg_add cmake gtk3mm atk2mm g++ sqlite libhandy glib2mm c++ gcc nlohmann-jsonp libwebsockets spdlog

git clone https://github.com/uowuo/abaddon.git ~/.local/src/abaddon

cd ~/.local/src/abaddon && git submodule update --init --recursive

mkdir build && cd build

cmake -GNinja ..

ninja

doas ninja install

ln -s ../res/css ./css
ln -s ../res/res ./res
ln -s ../res/fonts ./fonts

sed -i 's/141414/222222/g' ../res/css/main.css
sed -i 's/111111/1F1F1F/g' ../res/css/main.css
