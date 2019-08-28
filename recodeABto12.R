args = commandArgs(trailingOnly = T)

snpTable = args[1]
outFile = args[2]

# snpDat = read.csv("SNP TABLES/omni-HumanOmniExpress-12v1-Multi_B.update_alleles.txt/omni.txt", sep="\t", header=F)
snpDat = read.csv(snpTable, sep="\t", header=F, stringsAsFactors=F)

for(r in 1:nrow(snpDat)) {
  row = snpDat[r,]
  row$V2 = gsub(pattern = "A", replacement = "1", x = row$V2)
  row$V2 = gsub(pattern = "B", replacement = "2", x = row$V2)

  snpDat[r,] = row
}

write.table(snpDat, file = outFile, sep="\t", col.names = F, row.names=F)
