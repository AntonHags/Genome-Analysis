#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 08:00:00
#SBATCH -J blast
#SBATCH --mail-type=ALL
#SBATCH --mail-user=anton.hagstrom.3966@student.uu.se
#SBATCH --output=%x.%j.out

module load bioinfo-tools
module load blast

R7="/home/antonh/Genome-Analysis/analyses/polishing/R7/R7_pilon_polished.fasta"
HP126="/home/antonh/Genome-Analysis/analyses/polishing/HP126_pilon_polished.fasta"

cp $R7 $HP126 $SNIC_TMP/

cd $SNIC_TMP

makeblastdb -in R7_pilon_polished.fasta -dbtype nucl -out R7_db

blastn -query HP126_pilon_polished.fasta -db R7_db -out HP126_vs_R7.blast -outfmt 6 -num_threads 2 -evalue 1e-10

makeblastdb -in HP126_pilon_polished.fasta -dbtype nucl -out HP126_db

blastn -query R7_pilon_polished.fasta -db HP126_db \
  -out R7_vs_HP126.blast -outfmt 6 -evalue 1e-10


OUTDIR="/home/antonh/Genome-Analysis/analyses/blast"
mkdir -p $OUTDIR
cp *.blast $OUTDIR
cp *.fasta $OUTDIR
#cp *.crunch $OUTDIR
