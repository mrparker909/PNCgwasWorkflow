#!/bin/bash
#PBS -q medium

#PBS -N preImputeAlign-Quad
#PBS -l mem=30gb
#PBS -l walltime=2:00:00
#PBS -l procs=1

#PBS -o /zfs3/users/matthew.parker/matthew.parker/PBSlogs/log_$PBS_JOBID.txt
#PBS -e /zfs3/users/matthew.parker/matthew.parker/PBSlogs/err_$PBS_JOBID.txt

echo "Changing to directory containing gwasqc."
cd /zfs3/users/matthew.parker/matthew.parker/PBSscripts/GenotypeImputation/gwasqc/out
echo "Starting script at `date`"

module load plink2

HRCDir="../../HRC-1000G-check-bim-v4.2.11-NoReadKey/HRC-1000G-check-bim-NoReadKey.pl"
REFDir="../../HRC.r1-1.GRCh37.wgs.mac5.sites.tab"

perl $HRCDir -b GO_Quad.bim -f GO_Quad.post.frq -r $REFDir -h
# DO NOT FORGET TO RUN THIS AFTER THIS SCRIPT COMPLETES, BEFORE CONTINUING FURTHER: sh Run-plink.sh

echo "script completed at `date`"
