
#!/bin/bash
#PBS -q medium

#PBS -N preImputeQc
#PBS -l mem=10gb
#PBS -l walltime=1:00:00
#PBS -l procs=1

#PBS -M mrparker909@gmail.com
#PBS -m abe
#PBS -o /zfs3/users/matthew.parker/matthew.parker/PBSlogs/log_$PBS_JOBID.txt
#PBS -e /zfs3/users/matthew.parker/matthew.parker/PBSlogs/err_$PBS_JOBID.txt

cd /zfs3/users/matthew.parker/matthew.parker/PBSscripts/GenotypeImputation/gwasqc
echo "Current working directory is now: " `pwd`
echo "Starting script at `date`"

module load plink2
module load R
module load eigensoft
module load shapeit
module load impute2
module load vcftools/0.1.16 # for vcf-sort
module load samtools/1.9
module load htslib/1.9      # for bgzip

genDir="/zfs3/scratch/saram_lab/PNC/data/genotype/raw/EAsubjectOnly/recoded"
outDir=""
scrDir="/zfs3/users/matthew.parker/matthew.parker/PBSscripts/GenotypeImputation/gwasqc"
sex="/zfs3/scratch/saram_lab/PNC/data/phenotype/subjectSexInfo.txt"

sh $scrDir/pre_impute_qc_MOD.sh $genDir/GO_Omni $sex $outDir/GO_Omni
sh $scrDir/pre_impute_qc_MOD.sh $genDir/GO_Quad $sex $outDir/GO_Quad
sh $scrDir/pre_impute_qc_MOD.sh $genDir/GO_v1_hg18 $sex $outDir/GO_v1_hg18
sh $scrDir/pre_impute_qc_MOD.sh $genDir/GO_v3 $sex $outDir/GO_v3

echo "script completed at `date`"
