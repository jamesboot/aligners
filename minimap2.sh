#!/bin/bash
#SBATCH --job-name=ont_align
#SBATCH --output=ont_align_%j.log
#SBATCH --error=ont_align_%j.err
#SBATCH --time=24:00:00
#SBATCH --cpus-per-task=8
#SBATCH --mem=32G

# Load required modules
module load minimap2/2.26-GCCcore-12.2.0
module load SAMtools/1.18-GCC-12.3.0

# Input files (edit paths as needed)
FASTQ="reads.fastq.gz"         # Your ONT reads
REF="reference.fasta"          # Reference genome
OUT="ont_alignment.bam"        # Output BAM file

# Index reference if not already done
if [ ! -f ${REF}.mmi ]; then
    echo "Indexing reference genome..."
    minimap2 -d ${REF}.mmi ${REF}
fi

# Alignment and sorting
echo "Aligning reads..."
minimap2 -ax map-ont -t ${SLURM_CPUS_PER_TASK} ${REF}.mmi ${FASTQ} \
    | samtools view -bS - \
    | samtools sort -@ ${SLURM_CPUS_PER_TASK} -o ${OUT}

# Index BAM
samtools index ${OUT}

echo "Alignment finished. Output: ${OUT}"
