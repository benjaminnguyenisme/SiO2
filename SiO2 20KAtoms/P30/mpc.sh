#!/bin/bash

#PJM -g Q18246
#PJM -L rscunit=gwmpc
#PJM -L rscgrp=batch
#PJM -L node=16   
#PJM --mpi proc=512
#PJM -L elapse=72:00:00
#PJM -j
#PJM -N lammps

export OMP_NUM_THREADS=1

LAMMPS=../../../lammps-16Feb16/src-omp/lmp_fx100

cd ${PJM_O_WORKDIR}

module load sparc
module load fftw

mpirun ${LAMMPS} -in in.SiO2

