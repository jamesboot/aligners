#!/bin/bash

# Runs per sample portion of bismark methylation analysis of custom amplicon experiment
# Author: James Boot, Date: 16/02/2023
# Based on original scripts by Ian Donaldson and Anna Terry

# SECTION 1: EDIT HERE

##### Set queue options
#$ -cwd
#$ -j y
#$ -pe smp 6
#$ -l h_rt=240:0:0
#$ -l h_vmem=8G
#$ -N bismarkTest_GC-AS-10657					# Add traceable name
#$ -t 1-48													# Edit for the number of samples running (1-N)
#####

# SECTION 2: EDIT HERE
# Add config file path
# INPUT_DIR should be the trimgalore output directory
# OUTPUT_DIR should be the desired bismark output directory
# Leave REPCORES as is
source /data/WHRI-GenomeCentre/shares/Projects/NGS_Projects/DNA_Sequencing/Sharples_Adam/GC-AS-10657/Analysis/4.collectFiles/config.txt
INPUT_DIR=${ANALYSISDIR}/5.trimgalore_results
OUTPUT_DIR=${ANALYSISDIR}/6.bismark_test_results
REPCORES=$((NSLOTS / 2))

# SECTION 3:
# Set sample name and file names 
SAMPLE=$(sed -n -e "$SGE_TASK_ID p" trimmed_sample_names.txt)
INPUT1=$(sed -n -e "$SGE_TASK_ID p" trimmed_R1_file_list.txt)
INPUT2=$(sed -n -e "$SGE_TASK_ID p" trimmed_R2_file_list.txt)

echo "R1 file list for $SAMPLE: "
echo "$INPUT1"
echo ""
echo "R2 file list for $SAMPLE: "
echo "$INPUT2"

# All output files will be written to a single sub-directory for each sample
# Check output folder exists
if [ ! -e ${OUTPUT_DIR} ]; then mkdir -p ${OUTPUT_DIR}; fi
if [ ! -e ${OUTPUT_DIR}/${SAMPLE} ]; then mkdir -p ${OUTPUT_DIR}/${SAMPLE}; fi

# Bismark requires bowtie or bowtie2 depending on which was used to prepare the bisuphite converted genome and its index 
module load gcc/7.1.0
module load bowtie2/2.4.1
module load samtools/1.6
module load bismark/0.22.1

# Run Bismark
echo -e "Starting bismark for ${SAMPLE}."
bismark \
--bowtie2 \
--output_dir ${OUTPUT_DIR}/${SAMPLE} \
--temp_dir ${OUTPUT_DIR}/${SAMPLE} \
${GENOME_DIR} \
-1 ${INPUT1} \
-2 ${INPUT2} \
-p ${REPCORES} \
--pbat
