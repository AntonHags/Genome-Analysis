#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 01:00:00
#SBATCH -J Quality_control_RNA
#SBATCH --mail-type=ALL
#SBATCH --mail-user=anton.hagstrom.3966student.uu.se
#SBATCH --output=%x.%j.out

module load bioinfo-tools
module load FastQC

Input=/proj/uppmax2025-3-3/Genome_Analysis/2_Beganovic_2023/RNA_reads
Output=/home/antonh/Genome-Analysis/analyses/fastqc_raw

Samples=(SRR24516456 SRR24516457 SRR24516458 SRR24516459 SRR24516460 SRR24516461 SRR24516462 SRR24516463 SRR24516464)

mkdir -p "$Output"

for Sample in "${Samples[@]}"; do
	fastqc -o "$Output" "$Input"/"${Sample}"_1.fastq.gz "$Input"/"${Sample}"_2.fastq.gz
done


