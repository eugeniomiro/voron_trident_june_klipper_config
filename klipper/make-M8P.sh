cp .config-M8P ~/klipper/.config
pushd ~/klipper
make menuconfig
make clean
make
popd
