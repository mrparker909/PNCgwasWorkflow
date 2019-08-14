# PNCgwasWorkflow
Workflow for imputation of [https://www.ncbi.nlm.nih.gov/projects/gap/cgi-bin/study.cgi?study_id=phs000607.v1.p1](PNC) genomics data.

Order to run for genotype imputation:

| Filename               | Description                                                                                                |
| ---                    | ---                                                                                                        |
|00a-createPheno.R       |Run as Rscript to make phenotype file with FID and IID as first two columns                                 |
|00b-createFID_IID.R     |Run as Rscript to make FID_IID file                                                                         |
|00c-createSexInfo.R     |Run as Rscript to make subject sex information file                                                         |
|01a-subsetEA.sh         |Submit as PBS job to subset the genotype files for race = EA                                                |
|01b-recodeAlleles.sh    |Submit as PBS job to recode alleles from 12 (AB) coding to ACGT coding                                      |
|02a-preImputeQc.sh      |Submit as PBS job to perform quality checking                                                               |
|02b-alignment_Omni.sh   |Submit as PBS job to perform alignment using HRC, run Run-plink.sh before moving on                         |
|02b-alignment_Quad.sh   |Submit as PBS job to perform alignment using HRC, run Run-plink.sh before moving on                         |
|02b-alignment_v1.sh     |Submit as PBS job to perform alignment using HRC, run Run-plink.sh before moving on                         |
|02b-alignment_v3.sh     |Submit as PBS job to perform alignment using HRC, run Run-plink.sh before moving on                         |
|02c-bgzip.sh            |Submit as PBS job to compress chromosome files for upload to imputation server (Michigan Imputation Server) |

At this point imputation should be attempted/completed on the [https://imputationserver.sph.umich.edu](Michigan Imputation Server).

| Filename               | Description                                                                                                |
| ---                    | ---                                                                                                        |
|03a-reheader_Omni.sh    |Submit as PBS array job to reheader GO_Omni imputed chromosome files                                        |
|03b-reheader_Quad.sh    |Submit as PBS array job to reheader GO_Quad imputed chromosome files                                        |
|03c-reheader_v1_hg18.sh |Submit as PBS array job to reheader GO_v1_hg18 imputed chromosome files                                     |
|03d-reheader_v3.sh      |Submit as PBS array job to reheader GO_v3 imputed chromosome files                                          |
|04-merge.sh             |Merge the separate reheadered chip chromosome files into one set of chromosome files                        |
