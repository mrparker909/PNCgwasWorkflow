#!/bin/bash
#PBS -q medium

#PBS -N MergeChips
#PBS -l mem=30gb
#PBS -l walltime=60:00:00
#PBS -l procs=1

#PBS -o /zfs3/users/matthew.parker/matthew.parker/PBSlogs/log_$PBS_JOBID.txt
#PBS -e /zfs3/users/matthew.parker/matthew.parker/PBSlogs/err_$PBS_JOBID.txt

echo "Changing to directory containing gwasqc."
cd /zfs3/users/matthew.parker/matthew.parker/PBSscripts/GenotypeImputation/gwasqc
echo "Starting script at `date`"

module load plink2
module load R
module load eigensoft
module load shapeit
module load impute2
module load vcftools # for vcf-sort
module load samtools
module load htslib   # for bgzip
module load bcftools

GO_Omni="/zfs3/scratch/saram_lab/PNC/data/genotypeImputed/hrc/imputed_premerge/GO_Omni/reheadered"
GO_Quad="/zfs3/scratch/saram_lab/PNC/data/genotypeImputed/hrc/imputed_premerge/GO_Quad/reheadered"
GO_v3="/zfs3/scratch/saram_lab/PNC/data/genotypeImputed/hrc/imputed_premerge/GO_v3/reheadered"
GO_v1_hg18="/zfs3/scratch/saram_lab/PNC/data/genotypeImputed/hrc/imputed_premerge/GO_v1_hg18/reheadered"

sh post_reheader_merge.sh 1 22 $GO_Omni $GO_Quad $GO_v3 $GO_v1_hg18

echo "script completed at `date`"
