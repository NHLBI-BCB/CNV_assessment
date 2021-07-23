#!/bin/sh -l
#$ -cwd

scriptdir="/data/NHLBI_BCB/Mehdi/SEQC-WG1/22-CNV-MS/08_FACET"
d=$1
sid=$2

cd $scriptdir

module load R

Rscript --vanilla "$scriptdir/runFACETS_FS.R" $d $sid

