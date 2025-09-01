#!/bin/bash

#$ -M j.boot@qmul.ac.uk
#$ -m bes
#$ -cwd
#$ -j y
#$ -pe smp 2
#$ -l h_rt=01:00:00
#$ -l h_vmem=2G
#$ -N cellranger_mkgtf

# Load module
module load cellranger

# Define input parameters
GTF_IN=/data/WHRI-GenomeCentre/Genome/Mouse/GRCm39_r111/Mus_musculus.GRCm39.111.gtf
GTF_OUT=/data/WHRI-GenomeCentre/shares/Projects/NGS_Projects/10x_Chromium/Chaker_Ahmed/GC-ABC-10819/Analysis/customRef/Mm_GRCm39_111_filtered.gtf

# Run mkgtf
cellranger mkgtf \
${GTF_IN} \
${GTF_OUT} \
--attribute=gene_biotype:protein_coding
