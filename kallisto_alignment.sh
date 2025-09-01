#!/bin/bash
#$ -cwd						          # Set working directory to current directory
#$ -pe smp 4			        	# Request 4 cores
#$ -l h_vmem=8G		      		# Reuqest 8GB RAM
#$ -j y						          # Join stdout and stderr - standard output and standard error stream
#$ -l h_rt=24:00:00	    		# Request 24 hours run time
#$ -t 1-48			         		# Number of arrays to run - match to number of samples

INPUT_ARGS=$(sed -n "${SGE_TASK_ID}p" parameters_kallisto.txt)
READS1=$(echo $INPUT_ARGS | cut -d : -f 1)
READS2=$(echo $INPUT_ARGS | cut -d : -f 2)
SUBDIR=$(echo $INPUT_ARGS | cut -d : -f 3)

# We need to load the anaconda2 package in order to load the kallisto package
module load anaconda2

# Load the Kallisto package
source activate /data/WHRI-GenomeCentre/Kallisto_tool/

kallisto quant -i /data/WHRI-GenomeCentre/Genome/Human/hg19.GRCh38.99/kallisto/GRch38_v99_genome.idx \
-o $SUBDIR \
-b 100 \
-t $NSLOTS \
$READS1 $READS2
