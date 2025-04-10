#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 01:00:00
#SBATCH -J FastQC_Trimmed_DNA
#SBATCH --mail-type=ALL
#SBATCH --mail-user=anton.hagstrom.3966student.uu.se
#SBATCH --output=%x.%j.out

# Load FastQC module
module load bioinfo-tools
module load FastQC

# Define the input and output directories
InputDir="/home/antonh/Genome-Analysis/analyses/preprocess/trimming/DNA/"
OutputDir="/home/antonh/Genome-Analysis/analyses/preprocess/fastqc_trim/DNA/"

# Create the output directory if it doesn't exist
mkdir -p "$OutputDir"

# Run FastQC on the trimmed paired-end files
fastqc -o "$OutputDir" "$InputDir"/*_trimmed_1_paired.fastq.gz "$InputDir"/*_trimmed_2_paired.fastq.gz

