library(dplyr)
input = "/zfs3/scratch/saram_lab/PNC/data/phenotype/FID_IID_Neurodevelopmental_Genomics_Subject_Phenotypes.GRU-NPU.txt"
out2 = "/zfs3/scratch/saram_lab/PNC/data/phenotype/EAsubjectID/EAsubjectFID_IID.txt"
df  <- read.csv(input, header = TRUE, stringsAsFactors = FALSE, quote = "", sep = " ")
df2 <- dplyr::filter(df, Race %in% c("EA"))
#df3 <- dplyr::mutate(df2, FID=0,IID=SUBJID)
df4 <- dplyr::select(df2,FID,IID)
write.table(df4, out2, sep=" ", row.names = F,col.names=F, quote=F)
