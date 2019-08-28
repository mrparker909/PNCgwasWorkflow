#!/bin/bash
#PBS -q medium

#PBS -N PCA
#PBS -l mem=10gb
#PBS -l walltime=10:00:00
#PBS -l procs=1

#PBS -o /zfs3/users/matthew.parker/matthew.parker/PBSlogs/log_$PBS_JOBID.txt
#PBS -e /zfs3/users/matthew.parker/matthew.parker/PBSlogs/err_$PBS_JOBID.txt

module load eigensoft

cd /zfs3/scratch/saram_lab/PNC/data/genotypeImputed/hrc/postQC/

smartpca -p eigensoft_params.txt
