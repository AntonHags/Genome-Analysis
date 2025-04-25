#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 06:00:00
#SBATCH -J pilon_mapping_polish
#SBATCH --mail-type=ALL
#SBATCH --mail-user=anton.hagstrom.3966@student.uu.se
#SBATCH --output=%x.%j.out

set -e

module load bioinfo-tools
module load bwa
module load samtools
module load Pilon
module load java

WORKDIR="/home/antonh/Genome-Analysis/analyses/polishing"
ASSEMBLY="/home/antonh/Genome-Analysis/analyses/genome_assembly/HP126/assembly.fasta"
READ1="/proj/uppmax2025-3-3/Genome_Analysis/2_Beganovic_2023/DNA_reads/short_reads/SRR24413065_1.fastq.gz"
READ2="/proj/uppmax2025-3-3/Genome_Analysis/2_Beganovic_2023/DNA_reads/short_reads/SRR24413065_2.fastq.gz"
BAM="$WORKDIR/HP126_to_own.sorted.bam"

mkdir -p "$WORKDIR"

bwa index "$ASSEMBLY"

bwa mem -t 2 "$ASSEMBLY" "$READ1" "$READ2" > "$WORKDIR/HP126_to_own.sam"

samtools view -Sb "$WORKDIR/HP126_to_own.sam" | samtools sort -o "$BAM"
samtools index "$BAM"

java -Xmx16G -jar $PILON_HOME/pilon.jar \
  --genome "$ASSEMBLY" \
  --frags "$BAM" \
  --output "HP126_pilon_polished" \
  --tracks \
  --vcf \
  --fix all \
  --mindepth 10 \
  --changes \
  --outdir "$WORKDIR"


rm "$WORKDIR/HP126_to_own.sam"


