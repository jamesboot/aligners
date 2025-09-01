#!/bin/bash

#$ -M j.boot@qmul.ac.uk
#$ -m bes
#$ -cwd
#$ -j y
#$ -pe smp 8
#$ -l h_rt=24:00:00
#$ -l h_vmem=16G
#$ -l highmem
#$ -N cellranger_mkref

# Define parameters
GTF=/data/WHRI-GenomeCentre/shares/Projects/NGS_Projects/10x_Chromium/Chaker_Ahmed/GC-ABC-10819/Analysis/customRef/Mm_GRCm39_111_filtered_Cre.gtf
FASTA=/data/WHRI-GenomeCentre/shares/Projects/NGS_Projects/10x_Chromium/Chaker_Ahmed/GC-ABC-10819/Analysis/customRef/Mm_GRCm39_r111_Cre.fa
NAME=mm_Cre

# Load module
module load cellranger

# Run mkref
cellranger mkref --genome=${NAME} \
--fasta=${FASTA} \
--genes=${GTF}
