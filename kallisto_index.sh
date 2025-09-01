#!/bin/bash
# Set queue options
#$ -M j.boot@qmul.ac.uk             	# Send email to this address
#$ -m bea 				                  	# Email when completed
#$ -cwd					                    	# Set the working directory for the job to current directory
#$ -pe smp 8			                  	# Request 8 cores
#$ -l h_vmem=32G		                	# Request 32GB RAM
#$ -j y					                     	# Join stdout and stderr - standard output and standard error stream
#$ -l h_rt=06:00:00		               	# Request 6 hrs runtime
#$ -l highmem		                   		# Join high memory queue

# We need to load the anaconda2 package in order to load the kallisto package
module load anaconda2

# Load the Kallisto package
source activate /data/WHRI-GenomeCentre/Kallisto_tool/

# Run kallisto in index mode, use the ensembl cDNA reference *.cdna.all.fa.gz, kallisto can handle gzipped files
kallisto index -i /data/WHRI-GenomeCentre/Genome/Human/hg19.GRCh38.104/kallisto/GRch38_v104_genome.idx /data/WHRI-GenomeCentre/Genome/Human/hg19.GRCh38.104/Homo_sapiens.GRCh38.cdna.all.fa.gz
