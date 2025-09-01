#!/bin/bash

##Running cellranger for creating single cell matrix data
#Script is created by Hothri Moka h.moka@qmul.ac.uk 
# This script is made to create a sample.txt which will have a list of sample names. This text file is given as a input for running a array job for multiple samples. 

#####################################################################
##### SECTION 1 - Set queue options
#$ -M h.moka@qmul.ac.uk #change to your email id. 
#$ -m bes
#$ -V
#$ -pe smp 2
#$ -cwd
#$ -l h_vmem=2G
#$ -l h_rt=1:0:0
#$ -N text_file
#####################################################################

# SECTION 2 - Set PROJECTDIR to the path of the directory where all the subdirectories containing fastq files are located. 
# Refer to the file "making samples textfile.sh" 

PROJECTDIR=/data/WHRI-GenomeCentre/shares/Projects/NGS_Projects/10x_Chromium/Project_Dir/FASTQ_DIRS

for i in $(ls {PROJECTDIR}/)
		do 
		echo $i >> samples.txt
		done 
