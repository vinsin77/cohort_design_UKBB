#!/bin/bash

#$ -cwd
#
# Task range. Tasks need to go from 1 to the number of files in the target
# directory. There is no easy way to do this programmatically: you have to
# count the number of files and edit the -t option accordingly
#$ -l h_rt=48:00:00
#$ -l h_vmem=30G
#$ -t 1-22
#$ -l rl9=true

JOB_ID=$SGE_TASK_ID
chr=$(head -n $SGE_TASK_ID chrom_list | tail -n 1)

source /etc/profile.d/modules.sh

module load roslin/bcftools/1.20

#for each chromosome vcf, select 20K controls and output into new vcf
#gzip and index each vcf

bcftools view -S 30K_euro_unrelated_control_IDs_for_pancancer /main_dir/ukk_project_dir/ukbb_project_c${chr}_v1.vcf.gz -Oz -o subset_VCFs_30K_euro_unrelated_controls/Controls_30K_chr${chr}_subset.vcf.gz 
bcftools index subset_VCFs_30K_euro_unrelated_controls/Controls_30K_chr${chr}_subset.vcf.gz
