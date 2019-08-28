#!/usr/bin/bash

# Merge the results of imputation into one dataset
# In case the output of imputation is chromosome-by-chromosome,
# merge across datasets so there is one file per chromosome.

# Input: starting chromosome number; ending chromosome number; folders specifying dataset;
#        assume each folder has chr1 through chr22
#        and each is named chr1.dose.normed.vcf.gz, chr2.dose.normed.vcf.gz, etc.
#        (after we do the reheadering, this is how MIS likes to give you the output)
# Output: 22 chromosome files for the merged dataset

# Required: BCFTools, samtools, tabix, hg19 reference FASTA file
#           (hg19.nochr.fa) where chromosomes are named "1", "2", instead of
#           "chr1", "chr2", etc.

source ./params/pre_impute_params
missing_header_line_file=scripts/missing_header_lines.txt
missing_header_line_number=11
hg19=/zfs3/users/matthew.parker/matthew.parker/PBSscripts/GenotypeImputation/hg19FASTA/hg19.nochr.fa
hrc=/zfs3/users/matthew.parker/matthew.parker/PBSscripts/GenotypeImputation/HRC.r1-1.GRCh37.wgs.mac5.sites.vcf.gz

start=$1
end=$2

for i in `seq $start $end`
do
  (
  echo chr$i: Current Date and Time is: `date +"%Y-%m-%d %T"`
  merge_args=""
  outputFilename=""
  for dirname in "${@:3}"
  do
    echo "chr$i: dirname=$dirname"
    dataname=$(basename $dirname)
    chrfname=chr$i.dose

    merge_args="$merge_args $dirname/$dataname.$chrfname.normed.vcf.gz"
    outputFilename="$outputFilename+$dataname"
  done
  # merge
  echo "chr$i: Merging files: $merge_args"
  merge_args=${merge_args:1}
  outputFilename=${outputFilename:1}.$chrfname.vcf.gz
  time bcftools merge $merge_args -O z -o $outdir/$outputFilename
  ) &
done
wait
