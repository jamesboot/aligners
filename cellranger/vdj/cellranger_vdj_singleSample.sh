#!/bin/bash 

# Script was written by James Boot j.boot@qmul.ac.uk 
# This script run VDJ analysis on one 10X single cell sample

#### SECTION 1 - Set queue options
#$ -M h.moka@qmul.ac.uk                # Add your email 
#$ -m bes                              # Request email notifications
#$ -cwd                                # Set to current working directory
#$ -pe smp 10                          # Request xx cores
#$ -l h_rt=70:0:0                      # Request xx running time
#$ -l h_vmem=10G                       # Request xx memory
#$ -N cellranger_vdj                   # Name the job
#$ -j y                                # Join standard error/output stream
####

#### SECTION 2 - Load the module 
module load cellranger
    
#### SECTION 3 - Commands to run count 
# Set --id to the name of the output file to be created. Note: the new version requires the id and sample name to be different.
# Set --fastqs to the location of the fastq files. 
# Set --reference to the location of the genome reference files. 
# Set --sample to the sample name 

cellranger vdj --id=EP3D-wetfail-count-3chem \
                 --fastqs=/data/WHRI-GenomeCentre/shares/Projects/NGS_Projects/10x_Chromium/Milligan_Deborah/GC-DAM-8057/Analysis/cellranger_3.0.1_scripts/GC-DAM-8057/outs/fastq_path/HWK3LBGX9/ \
                 --reference=/data/WHRI-GenomeCentre/Genome/cellranger_5.0_references/human/vdj_ref/refdata-cellranger-vdj-GRCh38-alts-ensembl-5.0.0/ \
                 --sample=EP3D-repeat
