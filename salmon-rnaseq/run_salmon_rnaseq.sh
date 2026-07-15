#!/bin/bash
#SBATCH --job-name=salmon_rnaseq
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=16
#SBATCH --mem=96GB
#SBATCH --time=24:00:00
#SBATCH --output=salmon_%j.out
#SBATCH --error=salmon_%j.err

# Project and software paths
PROJECT_DIR="/path/to/project"
CONDA_SETUP="/path/to/anaconda3/etc/profile.d/conda.sh"

# Existing Salmon transcriptome index
SALMON_INDEX="/path/to/reference/salmon_index"

cd "${PROJECT_DIR}" || exit 1

mkdir -p salmon_results/{fastqc_raw,multiqc_raw,trimmed,fastqc_trimmed,multiqc_trimmed,quant}

source "${CONDA_SETUP}"
conda activate salmon_env

# -----------------------------
# Raw-read quality control
# -----------------------------

fastqc \
  -t 16 \
  -o salmon_results/fastqc_raw \
  data/*.fastq.gz

multiqc \
  salmon_results/fastqc_raw \
  -o salmon_results/multiqc_raw \
  -n multiqc_raw_reads.html

# -----------------------------
# Paired-end read trimming
# -----------------------------

for r1 in data/*_R1_001.fastq.gz
do
    r2="${r1/_R1_001.fastq.gz/_R2_001.fastq.gz}"

    trim_galore \
      --cores 8 \
      --paired \
      --gzip \
      --output_dir salmon_results/trimmed \
      "${r1}" \
      "${r2}"
done

# -----------------------------
# Trimmed-read quality control
# -----------------------------

fastqc \
  -t 16 \
  -o salmon_results/fastqc_trimmed \
  salmon_results/trimmed/*val*.fq.gz

multiqc \
  salmon_results/fastqc_trimmed \
  -o salmon_results/multiqc_trimmed \
  -n multiqc_trimmed_reads.html

# -----------------------------
# Transcript quantification
# -----------------------------

for r1 in salmon_results/trimmed/*_R1_001_val_1.fq.gz
do
    base=$(basename "${r1}" _R1_001_val_1.fq.gz)
    r2="salmon_results/trimmed/${base}_R2_001_val_2.fq.gz"

    salmon quant \
      --threads 16 \
      --libType IU \
      --index "${SALMON_INDEX}" \
      -1 "${r1}" \
      -2 "${r2}" \
      -o "salmon_results/quant/${base}"
done

echo "Salmon RNA-seq workflow completed."
