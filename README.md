# Bulk RNA-seq Analysis Workflows

This repository contains reusable bulk RNA-seq workflows for quality control, read trimming, alignment, transcript quantification, and gene-level counting.

The scripts are organized as examples of RNA-seq analysis on a high-performance computing system using Slurm. All file paths, sample names, and project-specific details have been replaced with general placeholders.

## Workflows

### 1. STAR and nf-core/rnaseq Workflow

This workflow includes:

- STAR genome index generation
- nf-core/rnaseq execution using Nextflow
- STAR alignment
- Salmon quantification within nf-core/rnaseq
- Custom resource settings for large-genome analysis
- An example nf-core samplesheet

Folder:

```text
star-nfcore/
```

### 2. Bowtie2 RNA-seq Workflow

This workflow includes:

- FastQC on raw reads
- MultiQC report for raw-read quality
- Paired-end read trimming using Trim Galore
- FastQC on trimmed reads
- MultiQC report for trimmed-read quality
- Alignment using an existing Bowtie2 index
- SAM-to-BAM conversion
- BAM sorting and indexing using Samtools
- Gene-level counting using featureCounts

Folder:

```text
bowtie2-rnaseq/
```

### 3. Salmon RNA-seq Workflow

This workflow includes:

- FastQC on raw reads
- MultiQC report for raw-read quality
- Paired-end read trimming using Trim Galore
- FastQC on trimmed reads
- MultiQC report for trimmed-read quality
- Transcript-level quantification using an existing Salmon index
- Generation of `quant.sf` files for each sample

The Salmon output can be imported into R using `tximport` and summarized to gene-level counts for downstream differential-expression analysis.

Folder:

```text
salmon-rnaseq/
```

## Tools and Technologies

- STAR
- Bowtie2
- Salmon
- nf-core/rnaseq
- Nextflow
- FastQC
- MultiQC
- Trim Galore
- Samtools
- featureCounts
- Conda
- Slurm
- Linux
- High-performance computing

## Repository Structure

```text
bulk-rnaseq-analysis-workflows/
├── star-nfcore/
│   ├── README.md
│   ├── build_star_index.sh
│   ├── run_nfcore_rnaseq.sh
│   ├── resources.config
│   └── samplesheet_example.csv
├── bowtie2-rnaseq/
│   ├── README.md
│   └── run_bowtie2_rnaseq.sh
├── salmon-rnaseq/
│   ├── README.md
│   └── run_salmon_rnaseq.sh
├── README.md
├── .gitignore
└── LICENSE
```

## Usage

Before running any script, update the example paths for:

- Project directory
- FASTQ files
- Reference genome
- Annotation file
- STAR, Bowtie2, or Salmon index
- Conda installation
- Output directories

The Slurm CPU, memory, partition, and runtime settings should also be adjusted based on the available computing environment and dataset size.

## Notes

This repository contains general workflow examples only.

No raw sequencing data, unpublished results, animal identifiers, private server paths, or institution-specific research information are included.

The scripts may require changes depending on the sequencing platform, read naming format, library type, reference genome, and computing system.
