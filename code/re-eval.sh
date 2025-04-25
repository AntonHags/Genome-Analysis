#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 01:00:00
#SBATCH -J QUAST_HP126_vs_R7
#SBATCH --mail-type=ALL
#SBATCH --mail-user=anton.hagstrom.3966@student.uu.se
#SBATCH --output=%x.%j.out

module load bioinfo-tools
module load quast

R7="/home/antonh/Genome-Analysis/analyses/genome_assembly/R7/assembly.fasta"
HP126="/home/antonh/Genome-Analysis/analyses/polishing/HP126_pilon_polished.fasta"
OUTDIR="/home/antonh/Genome-Analysis/analyses/assembly_comparison/quast_HP126_vs_R7"

mkdir -p "$OUTDIR"

quast.py "$R7" "$HP126" \
  -o "$OUTDIR" \
  --labels R7,HP126 \
  --threads 2

