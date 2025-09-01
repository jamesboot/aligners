#!/bin/bash 
# This script was written by James Boot j.boot@qmul.ac.uk. 
# This script run vdj analysis for multiple samples from cellranger

## THIS SCRIPT IS STILL UNDER DEVELOPMENT AND NEEDS TESTING

#### SECTION 1 - Set queue options

#$ -M j.boot@qmul.ac.uk                     # Add your email
#$ -m bes                                   # Request email notifications
#$ -pe smp 4                               # Request xx cores
#$ -cwd                                     # Set to current working directory
#$ -l h_vmem=8G                            # Request xxG RAM
#$ -l h_rt=100:0:0                          # Request xx hours run time 
#$ -N cellranger-vdj                        # Name the job
#$ -t 1-3                                   # Set -t to number of array tasks to run - change this based on number of samples
#$ -j y                                     # Join standard error / log stream

#### SECTION 2 - Load the module 

module load cellranger

#### SECTION 3 - Specify the parameters file and arguements to be used later
# parameters.txt is a text file which has mulitple lines - each sample is on a different line - needs to be prepared by user
# On each iteration of the array the script will use a different line i.e. iteration 1 = line 1, iteration 2 = line 2 etc.
# Each line contains multiple pieces of information for each sample separated by a colon
# First part of the line is the sample name (SAMPLE), then a colon, then the list of fastq directories (FASTQ_DIR) seperated by a comma
# Set REF to the file path where Reference genome files are located

INPUT_ARGS=$(sed -n "${SGE_TASK_ID}p" parameters.txt)
SAMPLE=$(echo $INPUT_ARGS | cut -d : -f 1)
FASTQ_DIR=$(echo $INPUT_ARGS | cut -d : -f 2)
REF=/data/WHRI-GenomeCentre/Genome/cellranger_5.0_references/human/vdj_ref/refdata-cellranger-vdj-GRCh38-alts-ensembl-5.0.0

#### SECTION 4    
# Commands to run VDJ
# Only thing to check here is: 
# --localmem= change to the same amount of memory requested in SECTION 1

cellranger vdj --id=${SAMPLE} \
                 --fastqs=${FASTQ_DIR} \
                 --reference=${REF} \
                 --sample=${SAMPLE} \
                 --jobmode=local \
                 --localcores=${NSLOTS} \
                 --localmem=8
