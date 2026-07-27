#!/bin/bash
#$ -N vcf_to_plink
#$ -cwd
#$ -o ../logs/$JOB_NAME.o$JOB_ID
#$ -e ../logs/$JOB_NAME.e$JOB_ID
#$ -l h_rt=06:00:00
#$ -l h_vmem=16G

source /etc/profile.d/modules.sh
module purge
module load plink/2.00a6LM


for chr in {1..22}; do
  plink2 \
    --vcf merged_vcfs/chr${chr}.vcf.gz \
    --vcf-half-call missing \
    --make-bed \
    --max-alleles 2 \
    --set-all-var-ids @:#:\$r:\$a \
    --new-id-max-allele-len 60 \
    --out plink_per_chr/chr${chr}
done
