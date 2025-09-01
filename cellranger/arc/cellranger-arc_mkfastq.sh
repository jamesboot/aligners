#!/bin/bash 

##Running cellranger-arc mkfastq to demultiplex raw sequence data (.bcl) into fastq files for downstream analysis. 

##### Set queue options
#$ -M e.wozniak@qmul.ac.uk
#$ -m bes
#$ -cwd  
#$ -pe smp 4 
#$ -l h_rt=40:0:0
#$ -l h_vmem=10G   
#$ -N arc_mkfastq-atac
#$ -j y
#####

### load the module ## 
module load cellranger-arc

### load bcl2fastq2 ##
module load bcl2fastq2

## run cellranger mkfastq ##
## --id is the name of the folder that will be created by cellranger mkfastq ##
## --run is the full path to the sequencing run folder ##
## --csv is the full path to the .csv file containing sample and index information
cellranger-arc mkfastq --id=Fastq-folder \
                   --run/path/to/sequence/run \
                   --csv=/path/to/simple.csv
                    
                    
