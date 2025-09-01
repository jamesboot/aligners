#!/bin/bash 

## Running cellranger for count analysis

#### Set queue options
#$ -M e.wozniak@qmul.ac.uk			# Add your email address
#$ -m bes					# Request email notifications
#$ -cwd						# Set to current working directory
#$ -pe smp 4					# Request 4 cores (so far no cellranger count jobs have exceeded 25G, thus 4 cores 8G should be fine)
#$ -l h_rt=24:0:0				# Request max running time
#$ -l h_vmem=8G					# Request 8G memory
#$ -N count-AB-9124				# Name the job
#$ -j y						# Join the standard error/output stream
####

### load the module
module load cellranger
    
## Commands to run count 
# --id is the name of the output folder created by cellranger count
# --fastqs is the directory containing the fastq files produced by cellranger mkfastq
# --transcriptome is the reference to align the data to
# --sample is the sample ID of the fastq files

cellranger count --id=GC-AB-9124-GEX_full \
                 --fastqs=/data/WHRI-GenomeCentre/shares/Projects/NGS_Projects/10x_Chromium/Biddle_Adrian/GC-AB-9124/Analysis/GC-AB-9124_fastq_full/outs/fastq_path/HGJY5BGXH \
                 --transcriptome=/data/WHRI-GenomeCentre/Genome/cellranger_5.0_references/human/refdata-gex-GRCh38-2020-A/ \
                 --sample=GC-AB-9124-GEX
				 
