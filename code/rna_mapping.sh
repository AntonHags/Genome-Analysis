#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 08:00:00
#SBATCH -J rna_mapping_R7_HP126
#SBATCH --mail-type=ALL
#SBATCH --mail-user=anton.hagstrom.3966@student.uu.se
#SBATCH --output=%x.%j.out

module load bioinfo-tools
module load bwa
module load samtools

READDIR="/proj/uppmax2025-3-3/Genome_Analysis/2_Beganovic_2023/RNA_reads"
OUTDIR="/home/antonh/Genome-Analysis/analyses/rna_mapping/R7_new"
GENOME="/home/antonh/Genome-Analysis/analyses/polishing/R7/R7_pilon_polished.fasta"

declare -A SAMPLES
SAMPLES[R7]="SRR24516464 SRR24516463 SRR24516462"
SAMPLES[HP126]="SRR24516461 SRR24516460 SRR24516459"

bwa index "$GENOME"

for STRAIN in R7 HP126; do
    mkdir -p "$OUTDIR/$STRAIN"
    
    for SAMPLE in ${SAMPLES[$STRAIN]}; do
        READ1="$READDIR/${SAMPLE}_1.fastq.gz"
        READ2="$READDIR/${SAMPLE}_2.fastq.gz"
        OUTBAM="$OUTDIR/$STRAIN/${SAMPLE}_${STRAIN}_to_R7_sorted.bam"

        echo "Mapping $SAMPLE ($STRAIN) to R7 genome..."

        bwa mem -t 2 "$GENOME" "$READ1" "$READ2" | \
            samtools view -Sb - | \
            samtools sort -o "$OUTBAM"

        samtools index "$OUTBAM"
    done
done

