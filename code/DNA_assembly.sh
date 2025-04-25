#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2                
#SBATCH -t 04:00:00          
#SBATCH -J Flye_DNA_Assembly 
#SBATCH --mail-type=ALL
#SBATCH --mail-user=anton.hagstrom.3966@student.uu.se
#SBATCH --output=%x.%j.out  

module load bioinfo-tools
module load Flye

InputDir="/proj/uppmax2025-3-3/Genome_Analysis/2_Beganovic_2023/DNA_reads"
OutputDir="/home/antonh/Genome-Analysis/analyses/genome_assembly/R7"

mkdir -p "$OutputDir"

flye --nano-raw "$InputDir"/SRR24413072.fastq.gz \
    --out-dir "$OutputDir" -t 2 

