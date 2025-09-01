#!/bin/bash

# Runs per sample portion of bismark methylation analysis
# Author: James Boot, Date: 16/02/2023
# Based on original scripts by Ian Donaldson and Anna Terry

# SECTION 1: EDIT HERE

##### Set queue options
#$ -cwd
#$ -j y
#$ -pe smp 6
#$ -l h_rt=240:0:0
#$ -l h_vmem=8G
#$ -N bismark_GC-EW                        					# Add traceable name
#$ -t 1-4													# Edit for the number of samples running (1-N)
#####

# SECTION 2: EDIT HERE
# Add config file path
# INPUT_DIR should be the trimgalore output directory
# OUTPUT_DIR should be the desired bismark output directory
# Leave REPCORES as is
source /data/WHRI-GenomeCentre/shares/Projects_RandD/GC-EW-11187/Analysis/Bismark/Human/config.txt
INPUT_DIR=${ANALYSISDIR}/trimgalore_results
OUTPUT_DIR=${ANALYSISDIR}/bismark_results
REPCORES=$((NSLOTS / 2))

# SECTION 3:
# Set sample name and file names 
INPUT_ARGS=$(sed -n -e "$SGE_TASK_ID p" bismark_inputs.txt)
INPUT1=$(echo ${INPUT_ARGS} | cut -d : -f 1)
INPUT2=$(echo ${INPUT_ARGS} | cut -d : -f 2)
SAMPLE=$(echo ${INPUT_ARGS} | cut -d : -f 3)

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
--prefix ${SAMPLE} \
${GENOME_DIR} \
-1 ${INPUT1} \
-2 ${INPUT2} \
-p ${REPCORES}