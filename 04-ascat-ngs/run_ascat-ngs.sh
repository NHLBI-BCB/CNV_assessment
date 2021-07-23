#!/bin/sh -l
#$ -cwd

/ascatngs/4.2.1/ascat.pl -outdir \
	-tumour T.bam \
	-normal N.bam \
	-reference hg38.fa \
	-snp_gc SnpGcCorrections_1000_hg38_unique_final.tsv \
	-gender XX \
	-genderChr X \
	-protocol WGS or WES