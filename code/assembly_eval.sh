#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 12:00:00
#SBATCH -J QUAST_Assembly_Evaluation
#SBATCH --mail-type=ALL
#SBATCH --mail-user=anton.hagstrom.3966@student.uu.se
#SBATCH --output=%x.%j.out

module load bioinfo-tools
module load quast

quast.py \
	/home/antonh/Genome-Analysis/analyses/polishing/HP126_pilon_polished.fasta \
	-o /home/antonh/Genome-Analysis/analyses/assembly_evaluation/HP126_new --threads 2

quast.py \
	/home/antonh/Genome-Analysis/analyses/polishing/R7/R7_pilon_polished.fasta \
	-o /home/antonh/Genome-Analysis/analyses/assembly_evaluation/R7_new --threads 2
	
