#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 01:00:00
#SBATCH -J Raw_Trimming_DNA
#SBATCH --mail-type=ALL
#SBATCH --mail-user=anton.hagstrom.3966student.uu.se
#SBATCH --output=%x.%j.out

# Load the necessary modules
module load bioinfo-tools
module load trimmomatic

# Set the input and output directories
InputDir="/proj/uppmax2025-3-3/Genome_Analysis/2_Beganovic_2023/DNA_reads/short_reads"
OutputDir="/home/antonh/Genome-Analysis/analyses/preprocess/trimming/DNA"

# Create the output directory if it doesn't exist
mkdir -p "$OutputDir"

# List of samples 
Samples=("SRR24413065" "SRR24413071" "SRR24413080")

# Loop through each sample and run Trimmomatic
for Sample in "${Samples[@]}"; do
    # Perform adapter and quality trimming on paired-end reads
    trimmomatic PE \
        "$InputDir"/"${Sample}"_1.fastq.gz "$InputDir"/"${Sample}"_2.fastq.gz \
       "$OutputDir"/"${Sample}"_trimmed_1_paired.fastq.gz "$OutputDir"/"${Sample}"_trimmed_1_unpaired.fastq.gz \
        "$OutputDir"/"${Sample}"_trimmed_2_paired.fastq.gz "$OutputDir"/"${Sample}"_trimmed_2_unpaired.fastq.gz \
        ILLUMINACLIP:$TRIMMOMATIC_ROOT/adapters/TruSeq3-PE.fa:2:30:10 \
	LEADING:20 TRAILING:20 SLIDINGWINDOW:4:20 MINLEN:36
done
    

