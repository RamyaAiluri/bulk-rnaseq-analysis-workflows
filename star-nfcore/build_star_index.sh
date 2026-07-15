#!/bin/bash
#SBATCH --job-name=star_index
#SBATCH --partition=large
#SBATCH --nodes=1
#SBATCH --cpus-per-task=24
#SBATCH --mem=500G
#SBATCH --time=2-00:00:00
#SBATCH --output=/path/to/logs/%x_%j.out
#SBATCH --error=/path/to/logs/%x_%j.err

# Reference files
FASTA="/path/to/reference/genome.fna"
GTF="/path/to/reference/annotation.gtf"

# Output directories
STAR_INDEX="/path/to/output/star_index"
LOG_DIR="/path/to/logs"

mkdir -p "${LOG_DIR}"
mkdir -p "${STAR_INDEX}"

# Load STAR
module load apps/star/2.7.11b

# Generate STAR genome index
STAR \
  --runMode genomeGenerate \
  --runThreadN 24 \
  --genomeDir "${STAR_INDEX}" \
  --genomeFastaFiles "${FASTA}" \
  --sjdbGTFfile "${GTF}" \
  --sjdbOverhang 100 \
  --limitGenomeGenerateRAM 480000000000

echo "STAR genome index generation completed."
