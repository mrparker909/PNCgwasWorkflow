#!/bin/bash
cd /zfs3/users/matthew.parker/matthew.parker/PBSscripts/GenotypeImputation/chromo/aligned/

# extract rsIDs from .bim files (chromosome files aligned to HRC reference)
for f in *.bim
do
  cut -f2 $f > ${f}.rsIDs
done

# concatenate rsIDs into one file
cat *.rsIDs > assayed.txt
