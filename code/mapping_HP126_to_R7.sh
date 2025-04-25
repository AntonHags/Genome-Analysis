#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 06:00:00
#SBATCH -J DNA_Mapping
#SBATCH --mail-type=ALL
#SBATCH --mail-user=anton.hagstrom.3966@student.uu.se
#SBATCH --output=%x.%j.out

set -e  

module load bioinfo-tools
module load bwa
module load samtools

REF_ORIG="/proj/uppmax2025-3-3/Genome_Analysis/2_Beganovic_2023/reference_genome/R7_genome.fasta"
READ1="/proj/uppmax2025-3-3/Genome_Analysis/2_Beganovic_2023/DNA_reads/short_reads/SRR24413065_1.fastq.gz"
READ2="/proj/uppmax2025-3-3/Genome_Analysis/2_Beganovic_2023/DNA_reads/short_reads/SRR24413065_2.fastq.gz"

WORKDIR="/proj/uppmax2025-3-3/nobackup/work/antonh"
mkdir -p "$WORKDIR"

FINALDIR="/home/antonh/Genome-Analysis/analyses/dna_mapping"
mkdir -p "$FINALDIR"

REF_COPY="$WORKDIR/R7_genome.fasta"
cp "$REF_ORIG" "$REF_COPY"

if [ ! -f "$REF_COPY.bwt" ]; then
    bwa index "$REF_COPY"
fi

bwa mem -t 2 "$REF_COPY" "$READ1" "$READ2" > "$WORKDIR/HP126_vs_R7.sam"

samtools view -@ 2 -Sb "$WORKDIR/HP126_vs_R7.sam" | samtools sort -@ 2 -o "$WORKDIR/HP126_vs_R7.sorted.bam"

rm "$WORKDIR/HP126_vs_R7.sam"

samtools index "$WORKDIR/HP126_vs_R7.sorted.bam"

cp "$WORKDIR/HP126_vs_R7.sorted.bam" "$FINALDIR/"
cp "$WORKDIR/HP126_vs_R7.sorted.bam.bai" "$FINALDIR/"



