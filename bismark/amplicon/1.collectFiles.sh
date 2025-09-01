#!/bin/bash

# Script to create setup files for sequencing analysis project
# Author: James Boot, Date: 15/02/2023
# Based on original script written by Anna Terry on 28/11/2016

# Find all fastq.gz files under a given directory
# Parse out file details from file name and place in a tab delimited file
# Get all unique sample IDs and place in a file

# SECTION 1: EDIT HERE

##### Set queue options
#$ -M j.boot@qmul.ac.uk
#$ -m bes
#$ -cwd
#$ -V
#$ -l h_vmem=1G
##$ -l h_rt=1:0:0
#$ -N collectFiles
#$ -j y
#####

source /data/WHRI-GenomeCentre/shares/Projects/NGS_Projects/DNA_Sequencing/Elliot_Ashleigh/GC-AE-10407/Analysis/config.txt

# SECTION 2: DO NOT EDIT
R1LISTFILE=${ANALYSISDIR}/R1_file_list.txt
R2LISTFILE=${ANALYSISDIR}/R2_file_list.txt
SAMPLELISTFILE=${ANALYSISDIR}/sample_name_list.txt

# Find read 1's
find ${FASTQDIR} -regex ".*_R1_.*\.fastq.gz"  ! -name "1M-*" | sort >> ${R1LISTFILE}

# Find read 2's - in this data they are labelled as R3 because R2 is UMI
find ${FASTQDIR} -regex ".*_R2_.*\.fastq.gz"  ! -name "1M-*" | sort >> ${R2LISTFILE}

# Get sample names 
sed 's:.*/::' ${R1LISTFILE} | sed 's:_.*::' >> ${SAMPLELISTFILE}
