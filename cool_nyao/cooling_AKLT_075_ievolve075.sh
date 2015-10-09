#!/bin/sh
#SBATCH --array=1
#SBATCH -e cooling_AKLT_075.err
#SBATCH -o cooling_AKLT_075.out
#SBATCH -c 16
#SBATCH -N 1
#SBATCH -t 3000
#SBATCH -p serial_requeue 
#SBATCH --mem=32000 

hostname

export OMP_NUM_THREADS=16

# backtick - excute whats inside as a command in shell, take the output turn it into a string that TH gets value of
# | is called a pipe, take the output of the command before it and feeds in as input into the next one
# bc is arbitrary precision calculation -l is option to bc
# dmu is also just the job number
# `echo "scale=4; ($SLURM_ARRAY_TASK_ID)/10.0" | bc -l`
# either use partition serial_requeue or general

export Lbath=13
export Lsys=10
export Lramp=7
export chi_max=3000
export eps_bath=0.2
export eps_sys=1.0
export ievolve_time=0.75
export cool_time=5
export dt_step=0.025
export AKLT=0.75
export cool_chunks=20

echo Cooling some AKLT!
date
echo 

python cooling_cluster.py $Lbath $Lsys $Lramp $chi_max $eps_bath $eps_sys $ievolve_time $cool_time $dt_step $AKLT $cool_chunks

echo
echo Finished
date
