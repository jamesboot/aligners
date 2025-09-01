#!/bin/bash 

## Running cellranger count for feature barcode samples

#### Set queue options
#$ -M e.wozniak@qmul.ac.uk			# Add your email
#$ -m bes					# Request email notifications
#$ -cwd						# Set to current working directory
#$ -pe smp 8					# Request xx cores
#$ -l h_rt=100:0:0				# Request xx running time
#$ -l h_vmem=10G				# Request xx memory
#$ -N count-FB					# Name the job
#$ -j y						# Join standard error / log stream
####

## Load the module 
module load cellranger
    
## Commands to run count
# --id is the name of the output folder that will be created by count analysis 
# Note: the new version requires the id and sample name to be different
# --transcriptome is the file path to the reference genome
# --feature-ref is the file path to the to the feature_ref.csv
# --libraries is the file path to the libraries.csv
cellranger count --id=VARIATION_OF_SAMPLE_NAME \
                 --transcriptome=/data/WHRI-GenomeCentre/Genome/cellranger_5.0_references/human/refdata-gex-GRCh38-2020-A/ \
		 --feature-ref=/path/to/example_feat_ref.csv \
		 --libraries=/path/to/example_libraries.csv
