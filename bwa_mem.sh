#!/bin/sh

# Created by Hothri Moka, and then editted by James Boot - j.boot@qmul.ac.uk on 07/01/22
# This script is used to run the alignment tool called bwa_mem for fastq files generated with guppy basecaller. 
# The sequence files are generated from Oxford Nanopore sequencer called MinION 
# BWA index may need to be prepared before running this script

##### SECTION 1 - Set queue options
#$ -cwd
#$ -pe smp 6
#$ -l h_rt=240:00:00
#$ -l h_vmem=30G
#$ -l highmem
#$ -N bwa_mem_MinION
#$ -j y
#$ -t 1-96
#####

## SECTION 2 - define some parameters
GENOME=/data/WHRI-GenomeCentre/Genome/Human/MinION
SAMPLE=$(sed -n "${SGE_TASK_ID}p" fastqc_params.txt)

## SECTION 3 - load bwa and samtool
module load samtools
module load bwa

# SECTION 4 - run bwa and also sort the files with samtool
bwa mem -x ont2d ${GENOME}/GCA_000001405.15_GRCh38_full_analysis_set.fna ${SAMPLE} > barcode${SGE_TASK_ID}_align.sam
