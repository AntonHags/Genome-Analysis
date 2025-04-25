#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 12:00:00
#SBATCH -J QUAST_R7_vs_HP126
#SBATCH --mail-type=ALL
#SBATCH --mail-user=anton.hagstrom.3966@student.uu.se
#SBATCH --output=%x.%j.out

module load bioinfo-tools
module load quast

AssemblyDir="/home/antonh/Genome-Analysis/analyses/genome_assembly"
OutputDir="/home/antonh/Genome-Analysis/analyses/assembly_evaluation/R7_vs_HP126"

mkdir -p "$OutputDir"

R7Assembly="$AssemblyDir/R7/assembly.fasta"
HP126Assembly="$AssemblyDir/HP126/assembly.fasta"

quast.py "$R7Assembly" "$HP126Assembly" \
    -o "$OutputDir" \
    --threads 2 \
    --fast

