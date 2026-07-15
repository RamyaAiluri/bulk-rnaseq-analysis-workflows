#!/bin/bash
#SBATCH --job-name=bowtie2_rnaseq
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=16
#SBATCH --mem=96GB
#SBATCH --time=24:00:00
#SBATCH --output=bowtie2_%j.out
#SBATCH --error=bowtie2_%j.err

# Project directory
PROJECT_DIR="/path/to/project"

# Reference files
BOWTIE2_INDEX="/path/to/reference/bowtie2_index/genome_index"
GTF="/path/to/reference/annotation.gtf"

# Conda installation
CONDA_SETUP="/path/to/anaconda3/etc/profile.d/conda.sh"

cd "${PROJECT_DIR}" || exit 1

mkdir -p bowtie2_results/{fastqc_raw,multiqc_raw,trimmed,fastqc_trimmed,multiqc_trimmed,alignments,counts}

source "${CONDA_SETUP}"
conda activate bowtie2_env

# -----------------------------
# Raw-read quality control
# -----------------------------

fastqc \
  -t 16 \
  -o bowtie2_results/fastqc_raw \
  data/*.fastq.gz

multiqc \
  bowtie2_results/fastqc_raw \
  -o bowtie2_results/multiqc_raw \
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
      --output_dir bowtie2_results/trimmed \
      "${r1}" \
      "${r2}"
done

# -----------------------------
# Trimmed-read quality control
# -----------------------------

fastqc \
  -t 16 \
  -o bowtie2_results/fastqc_trimmed \
  bowtie2_results/trimmed/*val*.fq.gz

multiqc \
  bowtie2_results/fastqc_trimmed \
  -o bowtie2_results/multiqc_trimmed \
  -n multiqc_trimmed_reads.html

# -----------------------------
# Bowtie2 alignment
# -----------------------------

for r1 in bowtie2_results/trimmed/*_R1_001_val_1.fq.gz
do
    base=$(basename "${r1}" _R1_001_val_1.fq.gz)
    r2="bowtie2_results/trimmed/${base}_R2_001_val_2.fq.gz"

    bowtie2 \
      -p 16 \
      -x "${BOWTIE2_INDEX}" \
      -1 "${r1}" \
      -2 "${r2}" \
      -S "bowtie2_results/alignments/${base}.sam"

    samtools sort \
      -@ 16 \
      -o "bowtie2_results/alignments/${base}.sorted.bam" \
      "bowtie2_results/alignments/${base}.sam"

    samtools index \
      "bowtie2_results/alignments/${base}.sorted.bam"

    rm "bowtie2_results/alignments/${base}.sam"
done

# -----------------------------
# Gene-level read counting
# -----------------------------

featureCounts \
  -T 16 \
  -p \
  -a "${GTF}" \
  -o bowtie2_results/counts/gene_counts.txt \
  bowtie2_results/alignments/*.sorted.bam

echo "Bowtie2 RNA-seq workflow completed."
