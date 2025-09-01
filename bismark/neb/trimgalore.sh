#!/bin/bash

# trimgalore-pe.sh
# Author: James Boot, Date: 15/02/2023
# Based on the version original written by Ian Donaldson and Anna Terry

# SECTION 1: EDIT HERE

##### Set queue options
#$ -M e.wozniak@qmul.ac.uk				# Add your email address
#$ -m bes
#$ -cwd
#$ -V
#$ -pe smp 6
#$ -l h_rt=240:0:0
#$ -l h_vmem=8G
#$ -N TrimGalore_EW-11187								# Add traceable name
#$ -j y
#####

source /data/WHRI-GenomeCentre/shares/Projects_RandD/GC-EW-11187/Analysis/Bismark/Human/config.txt

# SECTION 2: DO NOT EDIT

SAMPLE_NAMES=${ANALYSISDIR}/sample_name_list.txt
R1FILES=${ANALYSISDIR}/R1_file_list.txt
R2FILES=${ANALYSISDIR}/R2_file_list.txt

OUTPUT_DIR=${ANALYSISDIR}/trimgalore_results
FQC_OUTDIR=${OUTPUT_DIR}/post_trim_fastqc

# Check output folders exist
mkdir -p ${FQC_OUTDIR}
mkdir -p ${OUTPUT_DIR}
 
# Load trimgalore and cutadapt which is in a virtual environment
module load trimgalore

ITERATIONS=$(wc -l < ${SAMPLE_NAMES})

for i in $(seq ${ITERATIONS}); do
	
	echo "Iteration ${ITERATIONS}, file names and sample ID:"
	
	R1=$(sed -n "${i}p" ${R1FILES})
	echo "R1: ${R1}"
	
	R2=$(sed -n "${i}p" ${R2FILES})
	echo "R2: ${R2}"
	
	SAMPLE=$(sed -n "${i}p" ${SAMPLE_NAMES})
	echo "SAMPLE: ${SAMPLE}"
	
	echo "Running trim_galore..."
	
	# Run trimgalore
	trim_galore --quality 30 \
	--length 15 \
	--paired \
	--rrbs \
	--non_directional \
	--stringency 1 \
	-e 0.1 \
	--fastqc --fastqc_args "-o ${FQC_OUTDIR} --noextract" \
	--output_dir ${OUTPUT_DIR} \
	${R1} ${R2}
	
done

