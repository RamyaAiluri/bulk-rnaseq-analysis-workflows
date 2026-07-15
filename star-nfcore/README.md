# STAR and nf-core/rnaseq Workflow

This folder contains a bulk RNA-seq workflow that uses a custom STAR genome index with the nf-core/rnaseq pipeline.

The workflow is divided into two main steps:

1. Generate a STAR genome index from a reference genome and annotation file.
2. Run nf-core/rnaseq using Nextflow and the generated STAR index.

## Files

- `build_star_index.sh` – generates the STAR genome index
- `run_nfcore_rnaseq.sh` – runs the nf-core/rnaseq pipeline
- `nextflow.config` – contains example computing resource settings

The scripts use generic paths, file names, and computing settings. They can be modified for different bulk RNA-seq projects.

