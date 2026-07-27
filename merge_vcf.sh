#!/bin/bash
#$ -N merge_vcf_chr
#$ -cwd
#$ -o ../logs/$JOB_NAME.o$JOB_ID
#$ -e ../logs/$JOB_NAME.e$JOB_ID
#$ -l h_rt=04:00:00
#$ -l h_vmem=30G
#$ -t 1-22

# Get chromosome number from chrom_list
chr=$(head -n $SGE_TASK_ID chrom_list | tail -n 1)

# Load bcftools
source /etc/profile.d/modules.sh

module load bcftools/1.20
# Define file paths
CASE_VCF="/main_dir/lab_working_dir/UKBioBank2024/subset_VCFs_1224_CRC_euro_unrelated_cases/CRC_case_chr${chr}_subset.vcf.gz"
CONTROL_VCF="/main_dir/lab_working_dir/UKBioBank2024/my_dir/control_subset/Controls_chr${chr}_subset.vcf.gz"
OUT_DIR="/main_dir/lab_working_dir/UKBioBank2024/my_dir/merged_vcfs"
MERGED_VCF="${OUT_DIR}/chr${chr}.vcf.gz"

# Create output directory if needed
mkdir -p $OUT_DIR

# Merge case + control
bcftools merge $CASE_VCF $CONTROL_VCF -Oz -o $MERGED_VCF

# Index the merged VCF
bcftools index $MERGED_VCF
