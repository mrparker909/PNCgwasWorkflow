#!/usr/bin/bash

# Reheader the results of imputation.
# Perform corrections of errors in Michigan Imputation Server's output
# Including:
# 1. reheadering
# 2. recoding REF and ALT alleles

# Input: folder specifying dataset; number specifying chromosome number; assume each folder has chr1 through chr22
#        and each is named chr1.dose.vcf.gz, chr2.dose.vcf.gz, etc.
#        (this is how MIS likes to give you the output)
# Output: reheadered chromosome file

# Required: BCFTools, samtools, tabix, hg19 reference FASTA file
#           (hg19.nochr.fa) where chromosomes are named "1", "2", instead of
#           "chr1", "chr2", etc.

source ./params/pre_impute_params
missing_header_line_file=scripts/missing_header_lines.txt
missing_header_line_number=11
hg19=/zfs3/users/matthew.parker/matthew.parker/PBSscripts/GenotypeImputation/hg19FASTA/hg19.nochr.fa
hrc=/zfs3/users/matthew.parker/matthew.parker/PBSscripts/GenotypeImputation/HRC.r1-1.GRCh37.wgs.mac5.sites.vcf.gz

chrNum=$1

  merge_args=""
  outputFilename=""
  dirname=$2
  
  echo "chr$chrNum: dirname=$dirname"
  
  dataname=$(basename $dirname)
  chrfname=chr$chrNum.dose
  
  echo "chr$chrNum: dataname=$dataname"
  echo "chr$chrNum: Beginning reheader of /$chrfname.vcf.gz"

  # reheader
  tabix -H $dirname/$chrfname.vcf.gz > $tmpdir/$dataname.$chrfname.header
  sed -i "${missing_header_line_number}r $missing_header_line_file" $tmpdir/$dataname.$chrfname.header

  bcftools reheader -h $tmpdir/$dataname.$chrfname.header -o $tmpdir/$dataname.$chrfname.reheadered.vcf.gz $dirname/$chrfname.vcf.gz

  echo "chr$chrNum: Reheader of /$chrfname.vcf.gz completed"

  echo "chr$chrNum: Rebuilding index of /$chrfname.vcf.gz"
  # rebuild index
  bcftools index $tmpdir/$dataname.$chrfname.reheadered.vcf.gz

  echo "chr$chrNum: Annotating"
  
  bcftools annotate -a $hrc -c CHROM,POS,ID -O z -o $tmpdir/$dataname.$chrfname.annotated.vcf.gz $tmpdir/$dataname.$chrfname.reheadered.vcf.gz
  rm -f $tmpdir/$dataname.$chrfname.reheadered*
  tabix $tmpdir/$dataname.$chrfname.annotated.vcf.gz

  echo "chr$chrNum: Finished annotating"
  echo "chr$chrNum: Beginning recoding REF and ALT via bcftools norm"

  #recode REF and ALT (mutate the tmp file!)
  bcftools norm -d both -N -c ws -f $hg19 -O z -o $tmpdir/$dataname.$chrfname.normed.vcf.gz $tmpdir/$dataname.$chrfname.annotated.vcf.gz
  rm -f $tmpdir/$dataname.$chrfname.annotated*
  tabix $tmpdir/$dataname.$chrfname.normed.vcf.gz
  echo "chr$chrNum: Finished recoding"
