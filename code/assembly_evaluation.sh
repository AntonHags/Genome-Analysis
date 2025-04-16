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

AssemblyDir="/home/antonh/Genome-Analysis/analyses/genome_assembly"
OutputDir="/home/antonh/Genome-Analysis/analyses/assembly_evaluation/HP126"

mkdir -p "$OutputDir"

AssemblyFile="$AssemblyDir"/assembly.fasta  

ReferenceGenome="/proj/uppmax2025-3-3/Genome_Analysis/2_Beganovic_2023/reference_genome/HP126_genome.fasta" 

quast.py "$AssemblyFile" -o "$OutputDir" --threads 2 --reference "$ReferenceGenome" --fast


