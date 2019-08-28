# PNCgwasWorkflow
Workflow for imputation of [PNC](https://www.ncbi.nlm.nih.gov/projects/gap/cgi-bin/study.cgi?study_id=phs000607.v1.p1) genomics data (prior to genome wide association study). Details on how we used this workflow contained here: /documentation/Genotype-Imputation.pdf.

Order to run for genotype imputation:

| Filename               | Description                                                                                                |
| ---                    | ---                                                                                                        |
|00a-createPheno.R       |Run as Rscript to make phenotype file with FID and IID as first two columns                                 |
|00b-createFID_IID.R     |Run as Rscript to make FID_IID file                                                                         |
|00c-createSexInfo.R     |Run as Rscript to make subject sex information file                                                         |
|01a-subsetEA.sh         |Submit as PBS job to subset the genotype files for race = EA                                                |
|01b-recodeAlleles.sh    |Submit as PBS job to recode alleles from 12 (AB) coding to ACGT coding                                      |
|02a-preImputeQc.sh      |Submit as PBS job to perform quality checking                                                               |
|02b-alignment_Omni.sh   |Submit as PBS job to perform alignment using HRC, run sh Run-plink.sh before moving on                      |
|02b-alignment_Quad.sh   |Submit as PBS job to perform alignment using HRC, run sh Run-plink.sh before moving on                      |
|02b-alignment_v1.sh     |Submit as PBS job to perform alignment using HRC, run sh Run-plink.sh before moving on                      |
|02b-alignment_v3.sh     |Submit as PBS job to perform alignment using HRC, run sh Run-plink.sh before moving on                      |
|02c-bgzip.sh            |Submit as PBS job to compress chromosome files for upload to imputation server                              |
|02e-assayed.sh          |Run with: sh 02d-assayed.sh, should complete very quickly, produces assayed.txt                             |

At this point imputation should be attempted/completed on the [Michigan Imputation Server](https://imputationserver.sph.umich.edu).

| Filename               | Description                                                                                                |
| ---                    | ---                                                                                                        |
|02d-index.sh            |Submit as PBS job to index imputed files after download from imputation server                              |
|03a-reheader_Omni.sh    |Submit as PBS array job to reheader GO_Omni imputed chromosome files                                        |
|03b-reheader_Quad.sh    |Submit as PBS array job to reheader GO_Quad imputed chromosome files                                        |
|03c-reheader_v1_hg18.sh |Submit as PBS array job to reheader GO_v1_hg18 imputed chromosome files                                     |
|03d-reheader_v3.sh      |Submit as PBS array job to reheader GO_v3 imputed chromosome files                                          |
|04-merge.sh             |Merge the separate reheadered chip chromosome files into one set of chromosome files                        |
|05-final_merge.sh       |Merge the separate chromosome files into one single genotype file                                           |
|06-final_qc.sh          |Perform LD pruning, IBD pruning, output cleaned hrc file                                                    |
|07a-convert.sh          |Convert from  .ped/.map to EIGENSTRAT file format                                                           |
|07b-pca.sh              |Perform PCA to extract eigenvectors and eigenvalues                                                         |
