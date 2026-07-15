#!/bin/bash
#SBATCH --job-name=nfcore_rnaseq
#SBATCH --partition=large
#SBATCH --nodes=1
#SBATCH --cpus-per-task=24
#SBATCH --mem=500G
#SBATCH --time=3-00:00:00
#SBATCH --output=/path/to/project/logs/%x_%j.out
#SBATCH --error=/path/to/project/logs/%x_%j.err

# Project and reference directories
PROJECT_DIR="/path/to/project"
REF_DIR="/path/to/reference"

# Create required directories
mkdir -p "${PROJECT_DIR}/logs"
mkdir -p "${PROJECT_DIR}/results"
mkdir -p "${PROJECT_DIR}/work"

# Load Nextflow
module load nextflow

# Run nf-core/rnaseq
nextflow run nf-core/rnaseq \
  -r 3.26.0 \
  -profile conda \
  --input "${PROJECT_DIR}/samplesheet.csv" \
  --outdir "${PROJECT_DIR}/results" \
  --fasta "${REF_DIR}/genome.fna" \
  --gtf "${REF_DIR}/annotation.gtf" \
  --star_index "${REF_DIR}/star_index" \
  --aligner star_salmon \
  --bam_csi_index \
  --skip_biotype_qc \
  --skip_dupradar \
  --skip_bigwig \
  --max_cpus 24 \
  --max_memory 500.GB \
  -c "${PROJECT_DIR}/resources.config" \
  -w "${PROJECT_DIR}/work" \
  -resume

echo "nf-core/rnaseq workflow completed."
