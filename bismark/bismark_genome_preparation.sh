#!/bin/bash

# Script for the preparation of bismark reference genome
# See SOP on OneNote and repository on Github
# Modify the parameters section below as outlined in the SOP and then submit via qsub

# Job setup
#$ -M e.wozniak@qmul.ac.uk
#$ -m bes
#$ -cwd
#$ -j y
#$ -l h_rt=240:0:0
#$ -l h_vmem=10G
#$ -pe smp 2
#$ -N bmkGenPrep

# Input to the application is a directory path 'GENOME_DIR' which is expected to contain one or more fasta sequence files
# The default index will be made using (and compatible with) bowtie2 - if you want to use bowtie for the alignment, a separate index must be made specifying --bowtie
# Progress is sent to stdout and can be captured to a log.
# A new directory is made 'Bisulfite_Genome' in the same directory as GENOME_DIR.

GENOME_DIR=/data/WHRI-GenomeCentre/data/bismark/GC-VSN-8611

module load bowtie2/2.3.2
module load bismark/0.19.0

bismark_genome_preparation --verbose ${GENOME_DIR} \
	&> ${GENOME_DIR}/bismark_genome_preparation.log

exit