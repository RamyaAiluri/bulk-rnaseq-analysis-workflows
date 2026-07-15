# Bowtie2 Bulk RNA-seq Workflow

This folder contains a bulk RNA-seq workflow using Bowtie2 for read alignment.

The workflow starts with raw paired-end FASTQ files and performs quality control, read trimming, alignment, BAM file generation, gene-level counting, and final quality assessment.

## Workflow Steps

1. Run FastQC on raw FASTQ files.
2. Generate a MultiQC report for the raw-read quality-control results.
3. Trim paired-end reads using Trim Galore.
4. Run FastQC on the trimmed FASTQ files.
5. Generate a second MultiQC report for the trimmed-read quality-control results.
6. Align trimmed reads to an existing Bowtie2 genome index.
7. Convert SAM files to sorted BAM files using Samtools.
8. Index the sorted BAM files.
9. Generate gene-level read counts using featureCounts.

## Tools Used

- FastQC
- MultiQC
- Trim Galore
- Bowtie2
- Samtools
- featureCounts
- Conda
- Slurm

## Bowtie2 Index

This workflow uses a previously generated Bowtie2 genome index.

The index-generation step is not included in this folder. The index path in the script should be replaced with the location of the available Bowtie2 index.

## Input Files

The workflow expects paired-end FASTQ files with names similar to:

```text
sample1_R1_001.fastq.gz
sample1_R2_001.fastq.gz
