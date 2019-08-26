#!/bin/bash
#PBS -q medium

#PBS -N Final_QC
#PBS -l mem=10gb
#PBS -l walltime=4:00:00
#PBS -l procs=1

#PBS -o /zfs3/users/matthew.parker/matthew.parker/PBSlogs/log_$PBS_JOBID.txt
#PBS -e /zfs3/users/matthew.parker/matthew.parker/PBSlogs/err_$PBS_JOBID.txt

module load R
module load plink2

cd /zfs3/scratch/saram_lab/PNC/data/genotypeImputed/hrc/merged/

inFile="hrc_merged"
outFile="hrc.cleaned"
assayFile="/zfs3/scratch/saram_lab/PNC/data/genotype/qc/EAsubjectOnly/post-align/assayed.txt"
ibdScript="/zfs3/users/matthew.parker/matthew.parker/PBSscripts/GenotypeImputation/gwasqc/scripts/ibd-cut.R"

# make binary files
plink --vcf ${inFile}.vcf.gz --make-bed --out tmp

# scan for incorrect strand assignment
# see plink.flipscan for main report
# echo "Beginning flip-scan..."
# plink --bfile tmp --flip-scan

echo "Beginning LD pruning..."
# LD-based pruning
plink --bfile tmp --extract $assayFile --indep-pairwise 1500 150 0.2
plink --bfile tmp --extract plink.prune.in --genome --make-bed --out pruned

echo "Beginning IBD cuts..."
# Cryptic relatedness check
Rscript $ibdScript pruned.genome pruned.ibdcuts
plink --bfile pruned --remove pruned.ibdcuts --make-bed --out $outFile

echo "Done"
