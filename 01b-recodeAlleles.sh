#!/bin/bash
#PBS -q medium

#PBS -N recodeAlleles
#PBS -l mem=10gb
#PBS -l walltime=30:00:00
#PBS -l procs=1

#PBS -M mrparker909@gmail.com
#PBS -m abe
#PBS -o /zfs3/users/matthew.parker/matthew.parker/PBSlogs/log_$PBS_JOBID.txt
#PBS -e /zfs3/users/matthew.parker/matthew.parker/PBSlogs/err_$PBS_JOBID.txt

cd $PBS_O_WORKDIR
echo "Current working directory is now: " `pwd`
echo "Starting script at `date`"

# PLINK2 CODE TO RECODE ALLELES
module load plink2

genDir="/zfs3/scratch/saram_lab/PNC/data/genotype/raw/EAsubjectOnly"
outDir="/zfs3/scratch/saram_lab/PNC/data/genotype/raw/EAsubjectOnly/recoded"
snpTableDir="/zfs3/users/matthew.parker/matthew.parker/PBSscripts/GenotypeImputation/snpTables/ready"

# NOTE: skipping affy since no EA subjects
# plink --bfile $genDir/GO_Affy60 --make-bed --out $outDir/GO_Affy60 --update-alleles $snpTableDir/affy.txt
# echo "affy alleles updated"

# NOTE: skipping axiom since only 3 EA subjects
# plink --bfile $genDir/GO_Axiom --make-bed --out $outDir/GO_Axiom --update-alleles $snpTableDir/axiom.txt
# echo "axiom alleles updated"

plink --bfile $genDir/GO_Omni --make-bed --out $outDir/GO_Omni --update-alleles $snpTableDir/omni.snptable
echo "omni alleles updated"
plink --bfile $genDir/GO_Quad --make-bed --out $outDir/GO_Quad --update-alleles $snpTableDir/quad.snptable
echo "quad alleles updated"
plink --bfile $genDir/GO_v1_hg18 --make-bed --out $outDir/GO_v1_hg18 --update-alleles $snpTableDir/v1.snptable
echo "v1 alleles updated"
plink --bfile $genDir/GO_v3 --make-bed --out $outDir/GO_v3 --update-alleles $snpTableDir/v3.snptable
echo "v3 alleles updated"

echo "script completed at `date`"
