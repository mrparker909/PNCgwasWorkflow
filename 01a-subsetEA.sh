#!/bin/bash
#PBS -q medium

#PBS -N subsetEA
#PBS -l mem=20gb
#PBS -l walltime=1:00:00
#PBS -l procs=1

#PBS -M mrparker909@gmail.com
#PBS -m abe
#PBS -o /zfs3/users/matthew.parker/matthew.parker/PBSlogs/log_$PBS_JOBID.txt
#PBS -e /zfs3/users/matthew.parker/matthew.parker/PBSlogs/err_$PBS_JOBID.txt

cd $PBS_O_WORKDIR
echo "Current working directory is now: " `pwd`
echo "Starting script at `date`"

# PLINK2 CODE TO SUBSET BY RACE=="EA"
module load plink2

pFile="/zfs3/scratch/saram_lab/PNC/data/phenotype/FID_IID_Neurodevelopmental_Genomics_Subject_Phenotypes.GRU-NPU.txt"
genDir="/zfs3/scratch/saram_lab/PNC/data/genotype/raw"
outDir="/zfs3/scratch/saram_lab/PNC/data/genotype/raw/EAsubjectOnly"
idFile="/zfs3/scratch/saram_lab/PNC/data/phenotype/EAsubjectID/EAsubjectFID_IID.txt"

plink --bfile $genDir/GO_Affy60 --make-bed --out $outDir/GO_Affy60 --pheno $pFile --mpheno 3 --keep $idFile
plink --bfile $genDir/GO_Axiom --make-bed --out $outDir/GO_Axiom --pheno $pFile --mpheno 3 --keep $idFile
plink --bfile $genDir/GO_Omni --make-bed --out $outDir/GO_Omni --pheno $pFile --mpheno 3 --keep $idFile
plink --bfile $genDir/GO_Quad --make-bed --out $outDir/GO_Quad --pheno $pFile --mpheno 3 --keep $idFile
plink --bfile $genDir/GO_v1_hg18 --make-bed --out $outDir/GO_v1_hg18 --pheno $pFile --mpheno 3 --keep $idFile
plink --bfile $genDir/GO_v3 --make-bed --out $outDir/GO_v3 --pheno $pFile --mpheno 3 --keep $idFile

echo "script completed at `date`"
