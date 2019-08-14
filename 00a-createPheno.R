# the phenotype file requires FID and IID as first two columns.
# phenotype file currently missing FID, but has IID=SUBJID
# .fam file has column1=FID, column2=IID
library(dplyr)
library(magrittr)
library(stringr)

# do we need every fam file?
pathToPheno = "/zfs3/scratch/saram_lab/PNC/data/phenotype/phs000607.v1.pht003445.v1.p1.c1.Neurodevelopmental_Genomics_Subject_Phenotypes.GRU-NPU.txt"
pathToFam1   = "/zfs3/scratch/saram_lab/PNC/data/genotype/raw/GO_Affy60.fam"
pathToFam2   = "/zfs3/scratch/saram_lab/PNC/data/genotype/raw/GO_Axiom.fam"
pathToFam3   = "/zfs3/scratch/saram_lab/PNC/data/genotype/raw/GO_Omni.fam"
pathToFam4   = "/zfs3/scratch/saram_lab/PNC/data/genotype/raw/GO_Quad.fam"
pathToFam5   = "/zfs3/scratch/saram_lab/PNC/data/genotype/raw/GO_v1_hg18.fam"
pathToFam6   = "/zfs3/scratch/saram_lab/PNC/data/genotype/raw/GO_v3.fam"
pathToOut   = "/zfs3/scratch/saram_lab/PNC/data/phenotype/FID_IID_Neurodevelopmental_Genomics_Subject_Phenotypes.GRU-NPU.txt"

# 1) read in phenotype file, rename SUBJID to IID
phen1 <- read.csv(pathToPheno, skip = 10, header = TRUE, sep = "\t")
phen2 <- phen1 %>% rename(IID=SUBJID)

# 2) read in .fam files
fam1   <- read.csv(pathToFam1, header = FALSE, sep = " ")
names(fam1) <- c("FID", "IID", 1:4)

fam2   <- read.csv(pathToFam2, header = FALSE, sep = " ")
names(fam2) <- c("FID", "IID", 1:4)

fam3   <- read.csv(pathToFam3, header = FALSE, sep = " ")
names(fam3) <- c("FID", "IID", 1:4)

fam4   <- read.csv(pathToFam4, header = FALSE, sep = " ")
names(fam4) <- c("FID", "IID", 1:4)

fam5   <- read.csv(pathToFam5, header = FALSE, sep = " ")
names(fam5) <- c("FID", "IID", 1:4)

fam6   <- read.csv(pathToFam6, header = FALSE, sep = " ")
names(fam6) <- c("FID", "IID", 1:4)

fam <- rbind(fam1,fam2,fam3,fam4,fam5,fam6)

# 3) subset .fam to FID and IID
FAM  <- fam %>% select(FID, IID)

# 4) left join phenotype with FID and IID by IID
newP  <- phen2 %>% left_join(FAM, by="IID")
print("old dim:")
dim(newP)

missingIIDs <- setdiff(phen2$IID, FAM$IID)
write.csv(x = missingIIDs, file = "./pheno_missingIIDS.csv")

# 5) ensure first two columns are FID and IID
newP2 <- mutate_all(newP[c("FID", "IID", setdiff(names(newP), c("FID","IID")))],stringr::str_replace_all, pattern=" ", replacement="")
print("new dim:")
dim(newP2)

table(newP2$Sex)

# 6) save new phenotype file
write.table(x = newP2, pathToOut, sep = " ", quote=F, row.names=F)
