#!/bin/bash

chip="GO_v3"

for i in {1..22}
do
  mv ${chip}.chr${i}.dose.normed.vcf.gz reheadered.chr${i}.dose.normed.vcf.gz
  mv ${chip}.chr${i}.dose.normed.vcf.gz.tbi reheadered.chr${i}.dose.normed.vcf.gz.tbi
  mv ${chip}.chr${i}.dose.header reheadered.chr${i}.dose.header
done
