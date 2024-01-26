#!/bin/sh

git clone https://github.com/bleachbit/bleachbit.git ~/.local/src/bleachbit

make -C po local

echo "Remove Wayland Section in bleachbit.py before running"
