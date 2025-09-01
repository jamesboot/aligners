#!/bin/bash 


##### Set queue options
#$ -M e.wozniak@qmul.ac.uk
#$ -m bes
#$ -cwd  
#$ -pe smp 4 
#$ -l h_rt=40:0:0
#$ -l h_vmem=10G   
#$ -N arc_count
#$ -j y
#####

### load the module ## 
module load cellranger-arc


cellranger-arc count --id=Sample-ID \
                   --reference=/data/WHRI-GenomeCentre/Genome/cellranger_5.0_references/atac/human/refdata-cellranger-arc-GRCh38-2020-A-2.0.0 \
                   --libraries=/path/to/libraries.csv
                    
                    
