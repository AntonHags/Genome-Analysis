#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 02:00:00
#SBATCH -J prokka_annotation
#SBATCH --mail-type=ALL
#SBATCH --mail-user=anton.hagstrom.3966@student.uu.se
#SBATCH --output=%x.%j.out

module load bioinfo-tools
module load prokka

WORKDIR="/home/antonh/Genome-Analysis/analyses/annotation"
HP126_FASTA="/home/antonh/Genome-Analysis/analyses/polishing/HP126_pilon_polished.fasta"
R7_FASTA="/home/antonh/Genome-Analysis/analyses/polishing/R7/R7_pilon_polished.fasta"

mkdir -p "$WORKDIR"

prokka --outdir "$WORKDIR/HP126_new" --prefix HP126 --cpus 2 "$HP126_FASTA"

prokka --outdir "$WORKDIR/R7_new" --prefix R7 --cpus 2 "$R7_FASTA"

