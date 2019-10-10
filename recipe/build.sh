#!/bin/bash

# only link libraries we actually use
export CFITSIO_LIBS="-L${PREFIX}/lib -lcfitsio"
export GSL_LIBS="-L${PREFIX}/lib -lgsl"

mkdir -p _build
pushd _build

# configure
${SRC_DIR}/configure \
	--prefix=${PREFIX} \
	--disable-gcc-flags \
	--enable-cfitsio \
	--enable-openmp \
	--enable-mpi \
	MPICC=${PREFIX}/bin/mpicc \
	MPICXX=${PREFIX}/bin/mpicxx \
	MPIFC=${PREFIX}/bin/mpifc

# build
make -j ${CPU_COUNT}

# check
make -j ${CPU_COUNT} check

# install
make -j ${CPU_COUNT} install
