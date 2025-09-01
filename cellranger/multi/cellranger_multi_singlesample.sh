#!/bin/bash 

# Script for running cellranger multi for analysing multiplexed samples

#### SECTION 1 - Set queue options

## for setting up the que and running the code instant use the following que options 
##### Set queue options
#$ -M j.boot@qmul.ac.uk
#$ -m bes
#$ -cwd
#$ -pe smp 4
#$ -l h_rt=40:0:0
#$ -l h_vmem=8G
#$ -N GC-WL-9932_multi
#$ -j y
#####

#### SECTION 2 - Load the module
module load cellranger

#### SECTION 3
# Run cellranger multi 
cellranger multi --id=sample-id-here \
--csv=/path/to/csv/config/file.csv
