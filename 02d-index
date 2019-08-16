#!/bin/bash

#PBS -q medium

#PBS -N indexOmni
#PBS -l mem=10gb
#PBS -l walltime=10:00:00
#PBS -l procs=1

#PBS -o /zfs3/users/matthew.parker/matthew.parker/PBSlogs/log_$PBS_JOBID.txt
#PBS -e /zfs3/users/matthew.parker/matthew.parker/PBSlogs/err_$PBS_JOBID.txt

module load bcftools

for i in 1 .. 22
do
        bcftools index chr${i}.dose.vcf.gz
done
