#!/bin/bash 

# Script for running cellranger-arc count on scRNAseq GEX and ATAC data
# Script submitted to SLURM scheduler as an array job

#SBATCH --job-name=cellranger-arc_count
#SBATCH --output=logs/cellranger-arc_count.out
#SBATCH --error=logs/cellranger-arc_count.err
#SBATCH --time=164:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=64G
#SBATCH --partition=ncpu
#SBATCH --array=1-5

# Specify inputs here
PROJDIR=/nemo/stp/babs/working/bootj/projects/morisn/konstantina.angoura/ka916
OUTDIR=${PROJDIR}/data/cellranger-arc
LOOKUP_FILE=libraries_lookup.csv
REF=/nemo/stp/babs/reference/Genomics/10x/10x_arc/refdata-cellranger-arc-mm10-2020-A-2.0.0

# Create output directory if it doesn't exist
mkdir -p ${OUTDIR}

# Specify sample information from LOOKUP_FILE using array number
LOOKUP=$(sed -n "${SLURM_ARRAY_TASK_ID}p" $LOOKUP_FILE)
SAMPLE=$(echo $LOOKUP | cut -d ',' -f 1)
LIBRARIES=$(echo $LOOKUP | cut -d ',' -f 2)

# Load cellranger-arc
ml CellRanger-ARC/2.0.2

# Change to output directory
cd ${OUTDIR}

# Print job information
echo "Running cellranger-arc count for sample: ${SAMPLE}"
echo "Using libraries: ${LIBRARIES}"

# Run cellranger-arc count
cellranger-arc count \
    --id=${SAMPLE} \
    --reference=${REF} \
    --libraries=${LIBRARIES} \
    --localcores=${SLURM_CPUS_PER_TASK} \
    --localmem=${SLURM_MEM_PER_NODE}