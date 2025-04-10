#!/usr/bin/env bash

#SBATCH --job-name=mafft
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --partition=ncpu
#SBATCH --time='72:00:00'
#SBATCH --mem=32G

# Script for running multiple sequence alignment using MAFFT

# Load the MAFFT module
ml MAFFT/7.505-GCC-11.3.0-with-extensions

# Define inputs and outputs
PROJECT_DIR=/nemo/stp/babs/working/bootj/projects/bauerd/ciaran.gilbride/oc43_homology
INPUT_FASTA=${PROJECT_DIR}/sequences.fasta
OUTPUT_FASTA=${PROJECT_DIR}/aligned_sequences.fasta

# Run MAFFT for multiple sequence alignment
mafft --auto ${INPUT_FASTA} > ${OUTPUT_FASTA}