#!/bin/sh -l
#$ -cwd

#Step 1

/0.9.5/cnvkit.py batch tumor.bam \
	--normal normal.bam \
	--method wgs \
	--fasta hg38.fa \
	--annotate hg38_refFlat.txt \
	--targets targets.bed \
	-p 8 \
	--drop-low-coverage \
	--output-dir reference.cnn

#Step 2

/0.9.5/cnvkit.py batch tumor.bam \
	-r reference.cnn \
	--output-dir sampleid.cns \
	-p 4

#Step 3

/0.9.5/cnvkit.py call sampleid.cns \
	-o sampleid.call.cns
