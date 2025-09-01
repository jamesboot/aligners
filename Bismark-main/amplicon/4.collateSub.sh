#!/bin/bash

# Runs collation of sample results from cov files output from bismark methylextract
# Author: James Boot, Date: 22/03/2024

# SECTION 1: EDIT HERE

##### Set queue options
#$ -cwd
#$ -j y
#$ -pe smp 1
#$ -l h_rt=1:0:0
#$ -l h_vmem=8G
#$ -N collateMeth					# Add traceable name
#####

# SECTION 2: Load R
module load R

# SECTION 3: Run collate function with arguments
Rscript --vanilla collate.R '/data/WHRI-GenomeCentre/shares/Projects/NGS_Projects/DNA_Sequencing/Elliot_Ashleigh/GC-AE-10407/Analysis' \
'_L001_R1_001_bismark_bt2_pe.bismark.cov.gz' \
'collated_results.csv'
