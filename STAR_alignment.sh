#!/bin/bash

# Set queue options
#$ -m e 					                # Email when completed
#$ -M j.boot@qmul.ac.uk 	        # Send email to this address
#$ -cwd						                # Set the working directory for the job to current directory
#$ -pe smp 4				              # Request 4 cores
#$ -l h_vmem=8G				            # Request 8GB RAM
#$ -j y						                # Join stdout and stderr - standard output and standard error stream
#$ -l h_rt=10:00:00			          # Request 10 hrs runtime
#$ -t 1-21					              # Threading option - this should match the number of samples 

# Do not edit this unless the parameters file name needs changing 
INPUT_ARGS=$(sed -n "${SGE_TASK_ID}p" parametersfile.txt)
READS1=$(echo ${INPUT_ARGS} | cut -d : -f 1)
READS2=$(echo ${INPUT_ARGS} | cut -d : -f 2)
SUBDIR=$(echo ${INPUT_ARGS} | cut -d : -f 3)

# Load module
module load star/2.7.0f

# Run STAR with --quantMode GeneCounts so that gene level counts are automatically output - then htseq does not need to be run
STAR --outSAMstrandField intronMotif \
--quantMode GeneCounts \
--outSAMtype BAM SortedByCoordinate \
--readFilesCommand zcat \
--genomeDir /path/to/index \
--readFilesIn ${READS1} ${READS2} \
--outFileNamePrefix ${SUBDIR} \
--runThreadN ${NSLOTS}						
