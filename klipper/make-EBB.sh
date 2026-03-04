cp .config-EBB ~/klipper/.config
pushd ~/klipper
make menuconfig
make clean
make
popd
