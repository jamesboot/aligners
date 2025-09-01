#!/bin/bash

# Runs per sample portion of bismark methylation analysis of custom amplicon experiment
# Author: James Boot, Date: 16/02/2023
# Based on original scripts by Ian Donaldson and Anna Terry

# SECTION 1: EDIT HERE

##### Set queue options
#$ -cwd
#$ -j y
#$ -pe smp 9
#$ -l h_rt=240:0:0
#$ -l h_vmem=7.5G
#$ -N methylextract_GC-AS-10657					# Add traceable name
#$ -t 1-48					# Edit for the number of samples running (1-N)
#####

# SECTION 2: EDIT HERE
# Add config.txt file location
# Leave REPCORES
# INPUT_DIR is the directory containing the dedup results
# OUTPUT_DIR is the directory where methylextract results will be saved
# SAMPLE is the parameters file where the sample names are saved 
source /data/WHRI-GenomeCentre/shares/Projects/NGS_Projects/DNA_Sequencing/Sharples_Adam/GC-AS-10657/Analysis/4.collectFiles/config.txt
REPCORES=$((NSLOTS / 3))
INPUT_DIR=${ANALYSISDIR}/7.dedup_results
OUTPUT_DIR=${ANALYSISDIR}/8.methylextract_results
SAMPLE=$(sed -n -e "$SGE_TASK_ID p" /data/WHRI-GenomeCentre/shares/Projects/NGS_Projects/DNA_Sequencing/Sharples_Adam/GC-AS-10657/Analysis/2.MergeRuns/sample_names.txt)

# Check output folder exists
if [ ! -e ${OUTPUT_DIR} ]; then mkdir -p ${OUTPUT_DIR}; fi

# Bismark requires bowtie or bowtie2 depending on which was used to prepare the bisuphite converted genome and its index 
module load gcc/7.1.0
module load bowtie2/2.4.1
module load samtools/1.6
module load bismark/0.22.1

# Do methylation extraction
echo -e "Starting bismark methylation extractor for ${SAMPLE}."
bismark_methylation_extractor \
--paired-end \
--bedgraph \
--counts \
--multicore ${REPCORES} \
--no_overlap \
--buffer_size 10G \
--cytosine_report \
--genome_folder ${GENOME_DIR} \
--output ${OUTPUT_DIR}/${SAMPLE} \
${INPUT_DIR}/${SAMPLE}_R1_processed_val_1_bismark_bt2_pe_dedup.deduplicated.bam
