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

WORKDIR="/home/antonh/Genome-Analysis/analyses/polishing/R7"
ASSEMBLY="/home/antonh/Genome-Analysis/analyses/genome_assembly/R7/assembly.fasta"
READ1="/proj/uppmax2025-3-3/Genome_Analysis/2_Beganovic_2023/DNA_reads/short_reads/SRR24413071_1.fastq.gz"
READ2="/proj/uppmax2025-3-3/Genome_Analysis/2_Beganovic_2023/DNA_reads/short_reads/SRR24413071_2.fastq.gz"
BAM="$WORKDIR/R7.sorted.bam"

mkdir -p "$WORKDIR"

bwa index "$ASSEMBLY"

bwa mem -t 2 "$ASSEMBLY" "$READ1" "$READ2" > "$WORKDIR/R7.sam"

samtools view -Sb "$WORKDIR/R7.sam" | samtools sort -o "$BAM"
samtools index "$BAM"

java -Xmx16G -jar $PILON_HOME/pilon.jar \
  --genome "$ASSEMBLY" \
  --frags "$BAM" \
  --output "R7_pilon_polished" \
  --tracks \
  --vcf \
  --fix all \
  --mindepth 10 \
  --changes \
  --outdir "$WORKDIR"


rm "$WORKDIR/R7.sam"


