#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 02:00:00
#SBATCH -J count_reads
#SBATCH --mail-type=ALL
#SBATCH --mail-user=anton.hagstrom.3966@student.uu.se
#SBATCH --output=%x.%j.out

module load bioinfo-tools
module load subread 

GFF="/home/antonh/Genome-Analysis/analyses/annotation/R7_new/R7.gff"
OUTDIR="$SNIC_TMP/featurecounts_output"
R7_BAMS="/home/antonh/Genome-Analysis/analyses/rna_mapping/R7_new/R7/*.bam"
HP126_BAMS="/home/antonh/Genome-Analysis/analyses/rna_mapping/R7_new/HP126/*.bam"

mkdir -p $OUTDIR

cp $GFF $SNIC_TMP/
cp $R7_BAMS $SNIC_TMP/
cp $HP126_BAMS $SNIC_TMP/

cd $SNIC_TMP

featureCounts -a R7.gff \
              -o $OUTDIR/R7_counts.txt \
              -t CDS \
              -g locus_tag \
              -s 0 \
              -T 2 -p \
              *.bam

ls -lh $SNIC_TMP
ls -lh $OUTDIR

cp -r $OUTDIR /home/antonh/Genome-Analysis/analyses/read_counts/

