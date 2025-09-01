# Bismark

## Bismark User Guide
http://www.bioinformatics.babraham.ac.uk/projects/bismark/Bismark_User_Guide.pdf

## bismark_genome_preparation.sh
- Script for preparing bismark genome index if required.

## amplicon
- This folder contains scripts for running Bismark on amplicon sequencing projects (paired-end).
1. Prepare `config.txt` and upload to Apocrita project Analysis folder
2. Specify location of `config.txt` in `1.collectFiles.sh`, edit queue options if neccessary and qsub
3. Specify location of `config.txt` in `2.bismark.sh`, edit queue options (array length) if neccessary and qsub
4. Specify location of `config.txt` in `3.methylextract.sh`, edit queue options (array length) if neccessary and qsub
5. Collate all results from all samples:
    - Specify the following parameters in the following order in `4.collateSub.sh`:
    - Analysis directory (full path)
    - The suffix of the .cov.gz files - everything after the sample name
    - The desired name of the output file (must end .csv)


## diagenode
- This folder contains scripts for running Bismark on Diagenode RRBS data, previously run for GC-AS-10308 and GC-AS-10657
- :exclamation: These scripts were previously run and then uploaded to GitHub, some modification and improvement will be needed next time they are run :exclamation:
1. Extract UMIs from UMI read and annotate paired end reads using `UMITools.sh`
    - :exclamation: User will need to prepare a conda/python environment with umitools installed: https://umi-tools.readthedocs.io/en/latest/INSTALL.html
2. Prepare `config.txt` - save to analysis directory
3. Specify location of `config.txt` in `collectFiles.sh`, edit queue options as necessary and qsub
    - :exclamation: Check the REGEX pattern used to find the R1s and R2s files in this script, adjust if necessary 
4. Specify location of `config.txt` in `trimgalore.sh`, edit queue options as necessary, and other parameters, and qsub
    - :exclamation: User will need to prepare a conda/python environment with trimgalore installed
    - :exclamation: Sample run in a for loop so can take a while for this script to run depending on sample number (overnight recommended)
5. Specify location of `config.txt` in `bismark.sh`, edit queue options as necessary, and other parameters, and qsub
    - :exclamation: Check that `--multicore` option has NOT been used, ensure that `-p` is used and the number of cores is set to `NCORES/2`
6. Specify location of `config.txt` in `dedup.sh`, edit queue options as necessary, and other parameters, and qsub
    - :exclamation: Final output files are output appended with .deduplicated.bam and .deduplication_report.txt and saved in working directory - move to appropriate folder on completion
7. Specify location of `config.txt` in `methylextract.sh`, edit queue options as necessary, and other parameters, and qsub
    - :exclamation: Check that `-p` is used and the number of cores is set to `NCORES/3`
    - :exclamation: Check the naming convention of the input file for the bismark_methylation_extractor function at the bottom of the script

## NEB
1. Prepare `config.txt` - save to analysis directory
2. Specify location of `config.txt` in `collectFiles.sh`, edit queue options as necessary and qsub
    - :exclamation: Check the REGEX pattern used to find the R1s and R2s files in this script, adjust if necessary
3. Specify location of `config.txt` in `bismark.sh`, edit queue options as necessary, and other parameters, and qsub
    - :exclamation: You need to prepare a `bismark_inputs.txt` parameters file before running this script, see the example file. should be location of R1, colon, location of R2, colon, sample name.
    - :exclamation: Check that `--multicore` option has NOT been used, ensure that `-p` is used and the number of cores is set to `NCORES/2`
4. Specify location of `config.txt` in `methylextract.sh`, edit queue options as necessary, and other parameters, and qsub
    - :exclamation: Check that `-p` is used and the number of cores is set to `NCORES/3`
    - :exclamation: A sample names file where each sample name is on a new line is required for this script and must be specified in the script