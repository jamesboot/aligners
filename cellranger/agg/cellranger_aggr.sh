#!/bin/bash 

# Running cellranger for aggregating multiple GEM wells with cellranger aggr 
# This script is written by Hothri Moka h.moka@qmul.ac.uk 
# This script takes a .csv file as an input and runs aggr analysis on cellranger count generated output files
# Before running this script create a .csv file 
# For more information about creating a .csv file please check the website link below
# https://support.10xgenomics.com/single-cell-gene-expression/software/pipelines/3.0/using/aggregate

#### SECTION 1 - Set queue options
#$ -M j.boot@qmul.ac.uk                             # Change to your email id
#$ -m bes                                           # Request email notifications
#$ -cwd                                             # Set to current working directory
#$ -pe smp 10                                       # Request xx cores
#$ -l h_rt=96:00:00                                 # Request xx running time
#$ -l h_vmem=10G                                    # Request xx memory
#$ -N Cellranger_aggr                               # Set name for job
#$ -j y                                             # Join standard error/output stream
####

#### SECTION 2 - Load the module
module load cellranger
    
    
#### SECTION 3 - Run cellranger aggr
# Set --id to the prefered id (change the id according to the project name)
# Set --csv to the file path where .csv file is located - see example in Github repository
# Set --normalized to mapped (default) or to none

cellranger aggr --id=GC-AN-9192-Aggr \
                --csv=/data/WHRI-GenomeCentre/shares/Projects/NGS_Projects/10x_Chromium/Naeem_Arifa/GC-AN-9192/Analysis/aggr.csv \
                --normalize=mapped
