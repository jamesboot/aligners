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
#$ -t 1-2                                                               # Set -t to number of array tasks to run - change this based on number of samples
#####

#### SECTION 2 - Load the module
module load cellranger

#### SECTION 3 - Specify the parameters file and arguements to be used later
# parameters.txt is a text file which has mulitple lines - each sample is on a different line - needs to be prepared by user
# On each iteration of the array the script will use a different line i.e. iteration 1 = line 1, iteration 2 = line 2 etc.
# Each line contains multiple pieces of information for each sample separated by a colon
# First part of the line is the sample name (SAMPLE), then a colon, then the CSV directory for the config file (CSV_DIR)
INPUT_ARGS=$(sed -n "${SGE_TASK_ID}p" parameters.txt)
SAMPLE=$(echo $INPUT_ARGS | cut -d : -f 1)
CSV_DIR=$(echo $INPUT_ARGS | cut -d : -f 2)

#### SECTION 4
# Run cellranger multi 
cellranger multi --id=$SAMPLE \
--csv=$CSV_DIR
