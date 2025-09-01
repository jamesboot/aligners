#!/bin/bash

##### Set queue options
#$ -M j.boot@qmul.ac.uk               # Email address
#$ -m bes                             # Send email
#$ -cwd
#$ -pe smp 8                          # Cores
#$ -l h_vmem=16G                      # Memory
#$ -l h_rt=240:00:00                   # Running time
#$ -N BWA_Human_align                 # Rename this
#$ -j y
#$ -t 1-20                            # Set -t to number of array tasks to run - change this based on number of samples
#####

# Use a parameters file to specify information about each array task e.g. directory of sample reads 1 and 2
# See bwa_params.txt file in the github repository as an example
# Generally each line should be: path/to/read1:path/to/read2/:sample_name
# If multiple files exist for reads 1 and 2 for 1 sample (i.e. multiple lanes) then these can be specified by using a comma
INPUT_ARGS=$(sed -n "${SGE_TASK_ID}p" bwa_params.txt)
READ1=$(echo $INPUT_ARGS | cut -d : -f 1)
READ2=$(echo $INPUT_ARGS | cut -d : -f 2)
OUTPUT=$(echo $INPUT_ARGS | cut -d : -f 3)

# Load the module 
module load bwa

# Run BWA MEM
# Use > to direct the output into a sam file
# First arguement is the prefix of the index name
# Then reads 1 and 2
# -t option is the number of threads - keep as NSLOTS
bwa mem bwa_hg19_small $READ1 $READ2 -t $NSLOTS > ${OUTPUT}_bwa_mem_align.sam
