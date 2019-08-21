#!/bin/bash
#PBS -q medium

#PBS -N MergeChromosomes
#PBS -l mem=10gb
#PBS -l walltime=100:00:00
#PBS -l procs=1

#PBS -o /zfs3/users/matthew.parker/matthew.parker/PBSlogs/log_$PBS_JOBID.txt
#PBS -e /zfs3/users/matthew.parker/matthew.parker/PBSlogs/err_$PBS_JOBID.txt

echo "Starting script at `date`"

module load samtools
module load htslib   # for bgzip
module load bcftools

path="/zfs3/scratch/saram_lab/PNC/data/genotypeImputed/hrc/merged"
suffix=".dose.vcf.gz"
c1=$path/chr1$suffix
c2=$path/chr2$suffix
c3=$path/chr3$suffix
c4=$path/chr4$suffix
c5=$path/chr5$suffix
c6=$path/chr6$suffix
c7=$path/chr7$suffix
c8=$path/chr8$suffix
c9=$path/chr9$suffix
c10=$path/chr10$suffix
c11=$path/chr11$suffix
c12=$path/chr12$suffix
c13=$path/chr13$suffix
c14=$path/chr14$suffix
c15=$path/chr15$suffix
c16=$path/chr16$suffix
c17=$path/chr17$suffix
c18=$path/chr18$suffix
c19=$path/chr19$suffix
c20=$path/chr20$suffix
c21=$path/chr21$suffix
c22=$path/chr22$suffix
out=$path/hrc_merged.vcf.gz

bcftools concat $c1 $c2 $c3 $c4 $c5 $c6 $c7 $c8 $c9 $c10 $c11 $c12 $c13 $c14 $c15 $c16 $c17 $c18 $c19 $c20 $c21 $c22 -o $out -O z
