#!/bin/bash

# Set queue options
#$ -cwd														# Set the working directory for the job to current directory
#$ -pe smp 4												# Request 4 cores
#$ -l h_vmem=8G										# Request 8GB RAM
#$ -j y															# Join stdout and stderr - standard output and standard error stream
#$ -l h_rt=240:00:00									# Request max hrs runtime
#$ -t 1-48														# Threading option - this should match the number of samples 

# Edit here:
# DIR should be the directory containing fastq files (merge runs or lanes before if needed)
SAMPLE=$(sed -n "${SGE_TASK_ID}p" samples.txt)
DIR=/data/WHRI-GenomeCentre/shares/Projects/NGS_Projects/DNA_Sequencing/Sharples_Adam/GC-AS-10657/Analysis/2.MergeRuns

# Load module
module load anaconda3

# Load environment - User edit here to add your environment!
conda activate umitools 

# Run extract on samples that we sequenced 2 times
umi_tools extract --bc-pattern=NNNNNNNNN --stdin=${DIR}/${SAMPLE}_R2.fastq.gz --read2-in=${DIR}/${SAMPLE}_R1.fastq.gz --stdout=${SAMPLE}_R1_UMI.fastq.gz --read2-stdout --umi-separator=':'
umi_tools extract --bc-pattern=NNNNNNNNN --stdin=${DIR}/${SAMPLE}_R2.fastq.gz --read2-in=${DIR}/${SAMPLE}_R3.fastq.gz --stdout=${SAMPLE}_R3_UMI.fastq.gz --read2-stdout --umi-separator=':'