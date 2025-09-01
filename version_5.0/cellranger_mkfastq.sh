#!/bin/bash 

##Running cellranger mkfastq to demultiplex raw sequence data (.bcl) into fastq files for downstream analysis. 

##### Set queue options
#$ -M e.wozniak@qmul.ac.uk
#$ -m bes
#$ -cwd  
#$ -pe smp 4 
#$ -l h_rt=40:0:0
#$ -l h_vmem=10G   
#$ -N Cellranger_mkfastq
#$ -j y
#####

### load the module ## 
module load cellranger

### load bcl2fastq2 ##
module load bcl2fastq2

## run cellranger mkfastq ##
## --id is the name of the folder that will be created by cellranger mkfastq ##
## --run is the full path to the sequencing run folder ##
## --csv is the full path to the .csv file containing sample and index information
cellranger mkfastq --id=GC-AB-9124_fastq_full \
                   --run=/data/WHRI-GenomeCentre/shares/Projects/NGS_Projects/10x_Chromium/Biddle_Adrian/GC-AB-9124/Data/210205_NS500784_0753_AHGJY5BGXH \
                   --csv=/data/WHRI-GenomeCentre/shares/Projects/NGS_Projects/10x_Chromium/Biddle_Adrian/GC-AB-9124/Analysis/GC-AB-9124-simple.csv
                    
                    
                    
