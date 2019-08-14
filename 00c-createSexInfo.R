library(dplyr)
inp <- "/zfs3/scratch/saram_lab/PNC/data/phenotype/FID_IID_Neurodevelopmental_Genomics_Subject_Phenotypes.GRU-NPU.txt"
out <- "/zfs3/scratch/saram_lab/PNC/data/phenotype/subjectSexInfo.txt"

df  <- read.csv(inp, header = TRUE, stringsAsFactors = FALSE, quote = "", sep = " ", skip=0)
df2 <- dplyr::select(df,FID,IID,Sex)

print("Sex Summary:")
table(df2$Sex)
write.table(df2, out, sep=" ", row.names = F,col.names=F, quote=F)
