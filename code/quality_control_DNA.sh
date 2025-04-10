#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 01:00:00
#SBATCH -J Quality_Control_DNA
#SBATCH --mail-type=ALL
#SBATCH --mail-user=anton.hagstrom.3966@student.uu.se
#SBATCH --output=%x.%j.out

module load bioinfo-tools
module load FastQC

Input=/proj/uppmax2025-3-3/Genome_Analysis/2_Beganovic_2023/DNA_reads/short_reads
Output=/home/antonh/Genome-Analysis/analyses/fastqc_raw

mkdir -p "$Output"

Samples=(SRR24413065 SRR24413071 SRR24413080)

for Sample in "${Samples[@]}"; do
    fastqc -o "$Output" "$Input"/"${Sample}"_1.fastq.gz "$Input"/"${Sample}"_2.fastq.gz
done

