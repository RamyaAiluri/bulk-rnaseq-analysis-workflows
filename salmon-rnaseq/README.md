# Salmon Bulk RNA-seq Workflow

This folder contains a bulk RNA-seq workflow using Salmon for transcript-level quantification.

The workflow starts with paired-end FASTQ files and performs quality control, read trimming, transcript quantification, and summary report generation.

## Workflow Steps

1. Run FastQC on raw FASTQ files.
2. Generate a MultiQC report for the raw-read quality-control results.
3. Trim paired-end reads using Trim Galore.
4. Run FastQC on the trimmed FASTQ files.
5. Generate a second MultiQC report for the trimmed-read quality-control results.
6. Quantify transcript expression using a previously generated Salmon index.
7. Generate transcript-level abundance files for each sample.

## Tools Used

- FastQC
- MultiQC
- Trim Galore
- Salmon
- Conda
- Slurm

## Salmon Index

This workflow uses a Salmon transcriptome index that was generated separately.

The index-generation code is not included in this folder. The index path in the script should be replaced with the location of an existing Salmon index.

## Input Files

The workflow expects paired-end FASTQ files with names similar to:

```text
sample1_R1_001.fastq.gz
sample1_R2_001.fastq.gz
