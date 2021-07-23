#!/bin/sh -l
#$ -cwd

Rscript R/3.5/PureCN.R --genome hg38 \
	--force \
	--postoptimize \
	--seed 12 \
	--funsegmentation none \
	--segfile file.seg \
	--tumor file.cnr \
	--sampleid sampleid \
	--out .
