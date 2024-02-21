# Nextflow-pipeline-for-trimming-and-assembly

## Description
This Nextflow pipeline downloads raw reads using fasterq-dump, trims them using BBDuk, and assembles the trimmed reads using SKESA.

## Requirements
- [Nextflow](https://www.nextflow.io/)
- [fasterq-dump](https://github.com/ncbi/sra-tools): Available from [NCBI SRA Toolkit](https://github.com/ncbi/sra-tools)
- BBDuk: Available from [BBTools](https://jgi.doe.gov/data-and-tools/bbtools/bb-tools-user-guide/installation-guide/)
- SKESA: Available from [GitHub](https://github.com/ncbi/SKESA) or can be installed via [Conda](https://bioconda.github.io/recipes/skesa/README.html)

## Usage
1. **Clone the Repository**: Clone this repository to your local machine.

2. **Install Nextflow**: Make sure you have Nextflow installed on your system. You can download it from [here](https://www.nextflow.io/).

3. **Install Dependencies**: Install fasterq-dump, BBDuk, and SKESA on your system. You can download fasterq-dump from [NCBI SRA Toolkit](https://github.com/ncbi/sra-tools), BBDuk from [BBTools](https://jgi.doe.gov/data-and-tools/bbtools/bb-tools-user-guide/installation-guide/), and SKESA from [GitHub](https://github.com/ncbi/SKESA) or via [Conda](https://bioconda.github.io/recipes/skesa/README.html).

4. **Run the Pipeline**:
   ```bash
   nextflow run main.nf
