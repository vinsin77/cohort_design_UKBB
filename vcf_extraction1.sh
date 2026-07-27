#!/bin/bash
set -u

#
#Subset of 2036 samples
#


#$ -N subset_vcf_job
#$ -cwd 
#$ -o ../logs/$JOB_NAME.o$JOB_ID 
#$ -e ../logs/$JOB_NAME.e$JOB_ID 
#$ -l h_rt=48:00:00 
#$ -l h_vmem=10G
#$ -t rl9=true

source /etc/profile.d/modules.sh
module purge
module load bcftools/1.20



INPUT_PATH=/main_dir/lab_working_dir/genotypes/wes/v3/oqfe/pvcf/concat
SAMPLE_PATH=/main_dir/lab_working_dir/UKBioBank2024
OUTPUT_PATH=/main_dir/lab_working_dir/UKBioBank2024/subset_VCFs_CRC_cases
cd ${SAMPLE_PATH}


INPUT=${INPUT_PATH}/ukbb_project_c11_v1.vcf.gz

case_chr1_subset=${OUTPUT_PATH}/CRC_case_chr17_subset_${SGE_TASK_ID}.vcf.gz
sample_ids_file=${SAMPLE_PATH}/ukbb_1224_CRC_case_unrelated_Europeans_IDs



# Subset the VCF file by the sample IDs
bcftools view -S $sample_ids_file $INPUT -Oz -o $case_chr1_subset


# Index the final VCF file
bcftools index $case_chr1_subset
echo "Subsetting completed for task ID ${SGE_TASK_ID}. Final subset VCF file: $case_chr1_subset"
