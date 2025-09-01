#!/bin/bash
# This script is written by Hothri Moka h.moka@qmul.ac.uk 
# This script helps to create a reference genome index for the custom references, which can be used to run cellranger count. 

##### SECTION 1-  Set queue options
#$ -M h.moka@qmul.ac.uk   #change to your email id. 
#$ -m bes
#$ -cwd  
#$ -pe smp 20 
#$ -l h_rt=96:0:0
#$ -l h_vmem=24G   
#$ -N Cellranger5.0_custom_reference
#$ -j y
#####

### SECTION 2 -  load the module ## 
    module load cellranger/5.0.0
   
    
## SECTION 3 -  setting for running the program. 
# Set PROJECTDIR to the location of file path where the custom refernce gtf and fasta files are saved. 

PROJECTDIR=/data/WHRI-GenomeCentre/Genome/Cellranger 

# SECTION 4 - Filter with mkgtf
#gtf files downloaded from ENSEMBL and UCSC often contain transcripts and genes which need to be filtered from the final annotation. 

cellranger mkgtf $PROJECTDIR/input.gtf output.gtf --attribute=key:allowable_value

# SECTION 5 - Index with cellranger mkref 
cellranger mkref --genome=custom_genome \
                 --fasta=custom_reference.fa \
                 --genes=custom_filtered_gtf.gtf 
           
