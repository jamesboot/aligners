#!/bin/bash

# Script to create a BWA index file for alignment 
# This script is optimised for the human genome

##### Set queue options
#$ -M j.boot@qmul.ac.uk            # Email address
#$ -m bes                          # Send email
#$ -cwd
#$ -pe smp 8                       # Cores
#$ -l h_vmem=16G                   # Memory
#$ -l h_rt=240:00:00               # Running time
#$ -N BWA_Index                    # Rename this
#$ -j y
#####

# Define input file and output prefix
INPUT=Homo_sapiens.GRCh38.dna.primary_assembly.fa
PREFIX=bwa_hg38

# Load the module 
module load bwa

# Run BWA index
# -p option is the prefix of the output index
# -a option is the algorithm for creating the index - 'bwtsw' must be used for large genomes, 'is' must be used for small genomes
bwa index -p ${PREFIX} -a bwtsw ${INPUT}
