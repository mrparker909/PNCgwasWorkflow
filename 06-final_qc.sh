#!/bin/bash
#PBS -q medium

#PBS -N Final QC
#PBS -l mem=30gb
#PBS -l walltime=100:00:00
#PBS -l procs=1

#PBS -o /zfs3/users/matthew.parker/matthew.parker/PBSlogs/log_$PBS_JOBID.txt
#PBS -e /zfs3/users/matthew.parker/matthew.parker/PBSlogs/err_$PBS_JOBID.txt

module load R
module load plink2

cd /zfs3/scratch/saram_lab/PNC/data/genotypeImputed/hrc/merged/

$inFile="hrc.merged"
$outFile="hrc.cleaned"
$assayFile="/zfs3/scratch/saram_lab/PNC/data/genotype/qc/EAsubjectOnly/post-align/assayed.txt"

# scan for incorrect strand assignment
# see plink.flipscan for main report
echo "Beginning flip-scan..."
plink --bfile $inFile --flip-scan

echo "Beginning LD pruning..."
# LD-based pruning
plink --bfile $inFile --extract $assayFile --indep-pairwise 1500 150 0.2
plink --bfile $inFile --extract pruned --genome 0.05 gz

echo "Beginning IBD cuts..."
# Cryptic relatedness check
Rscript /zfs3/users/matthew.parker/matthew.parker/PBSscripts/GenotypeImputation/gwasqc/scripts/ibd-cut.R pruned.genome pruned.ibdcuts
plink --bfile pruned --remove pruned.ibdcuts --make-bed --out $outFile

echo "Done"
