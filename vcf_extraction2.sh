#!/bin/bash

set -u

#
#Subset of 1224 CRC samples
#


#$ -N subset_vcf_job
#$ -cwd
#$ -o ../logs/$JOB_NAME.o$JOB_ID
#$ -e ../logs/$JOB_NAME.e$JOB_ID
#$ -l h_rt=48:00:00
#$ -l h_vmem=30G
#$ -t 1-22
#$ -l rl9=true

JOB_ID=$SGE_TASK_ID
chr=$(head -n $SGE_TASK_ID chrom_list | tail -n 1)

source /etc/profile.d/modules.sh
module purge
module load bcftools/1.20


SAMPLE_PATH=/main_dir/lab_working_dir/UKBioBank2024
cd ${SAMPLE_PATH}
sample_ids_file=${SAMPLE_PATH}/ukbb_1224_CRC_case_unrelated_Europeans_IDs

#subset and index the each VCF file (22 chr)
bcftools view -S $sample_ids_file /main_dir/ukbb_project_dir/ukbb_project_c${chr}_v1.vcf.gz -Oz -o subset_VCFs_CRC_cases/CRC_case_chr${chr}_subset.vcf.gz 
bcftools index subset_VCFs_CRC_cases/CRC_case_chr${chr}_subset.vcf.gz
