#!/bin/bash 

#### SECTION 1 - Set queue options

#$ -N cellranger-count            # Name the job
#$ -M j.boot@qmul.ac.uk           # Add your email
#$ -m bes                         # Request email notifications
#$ -cwd                           # Set to current working directory
#$ -j y                           # Join standard error / log stream
#$ -pe smp 4                      # Request 4 cores (so far no cellranger count jobs have exceeded 25G, thus 4 cores 8G should be fine)
#$ -l h_vmem=8G                   # Request 8G RAM
#$ -l owned                       # Ask to use our dedicated node
#$ -l h_rt=240:00:00              # Request max run time - this does not impact queue time greatly 
#$ -t 1-4                         # Set -t to number of array tasks to run - change this based on number of samples


#### SECTION 2 - Load the module

module load cellranger

#### SECTION 3 - Specify the parameters file and arguements to be used later
# parameters.txt is a text file which has mulitple lines - each sample is on a different line - needs to be prepared by user
# On each iteration of the array the script will use a different line i.e. iteration 1 = line 1, iteration 2 = line 2 etc.
# Each line contains multiple pieces of information for each sample separated by a colon
# First part of the line is the sample name (SAMPLE), then a colon, then the list of fastq directories (FASTQ_DIR) seperated by a comma

INPUT_ARGS=$(sed -n "${SGE_TASK_ID}p" parameters.txt)
SAMPLE=$(echo $INPUT_ARGS | cut -d : -f 1)
FASTQ_DIR=$(echo $INPUT_ARGS | cut -d : -f 2)

#### SECTION 4    
# Commands to run count
# Ensure that localmem = the amount of memory requested in SECTION 1

cellranger count --id=${SAMPLE}_count \
--fastqs=$FASTQ_DIR \
--sample=$SAMPLE \
--transcriptome=/data/WHRI-GenomeCentre/Genome/cellranger_5.0_references/human/refdata-gex-GRCh38-2020-A/ \
--chemistry=auto \
--localcores=$NSLOTS \
--localmem=8 \
--jobmode=local
