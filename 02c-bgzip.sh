#!/bin/bash
#PBS -q medium

#PBS -N preImputeCompress
#PBS -l mem=30gb
#PBS -l walltime=1:00:00
#PBS -l procs=1

#PBS -o /zfs3/users/matthew.parker/matthew.parker/PBSlogs/log_$PBS_JOBID.txt
#PBS -e /zfs3/users/matthew.parker/matthew.parker/PBSlogs/err_$PBS_JOBID.txt

echo "Changing to directory containing gwasqc."
cd /zfs3/users/matthew.parker/matthew.parker/PBSscripts/GenotypeImputation/
echo "Starting script at `date`"

module load vcftools # for vcf-sort
module load samtools
module load htslib   # for bgzip

numchr=22
for i in `seq 1 $numchr`
do
  # compress
  vcf-sort ./chromo/aligned/GO_Omni-updated-chr$i.vcf | bgzip -c > ./chromo/compressed/GO_Omni.chr$i.vcf.gz
  vcf-sort ./chromo/aligned/GO_Quad-updated-chr$i.vcf | bgzip -c > ./chromo/compressed/GO_Quad.chr$i.vcf.gz
  vcf-sort ./chromo/aligned/GO_v1_hg18-updated-chr$i.vcf | bgzip -c > ./chromo/compressed/GO_v1_hg18.chr$i.vcf.gz
  vcf-sort ./chromo/aligned/GO_v3-updated-chr$i.vcf | bgzip -c > ./chromo/compressed/GO_v3.chr$i.vcf.gz
done

echo "script completed at `date`"
