#!/bin/sh -l
#$ -cwd

module load sequenza-utils
module load samtools

samtools mpileup -f hg38.fa -Q 20 normal.bam | gzip >normal.pileup.gz
samtools mpileup -f hg38.fa -Q 20 tumor.bam | gzip >tumor.pileup.gz

sequenza-utils bam2seqz  -gc hg38.gc50Base.txt.gz -p -n normal.pileup.gz -t tumor.pileup.gz -o sampleid.seqz.gz
sequenza-utils seqz_binning -w 100 -s sampleid.seqz.gz -o sampleid.seqz.bin.gz
