#!/bin/bash
set -e        # stop the script if a command fails

function fail {
    echo "FAIL: $@" >&2
    exit 1  # signal failure
}

bam=$1    
out=$2

echo -e "Start at `date +"%Y/%m/%d %H:%M:%S"`" 1>&2

module load samtools

#######################################################################################################
#
#
# Create pileups from the BAM files for FREEC input using the GDC reference
# https://gdc.cancer.gov/about-data/gdc-data-processing/gdc-reference-files
#
#
#######################################################################################################

samtools mpileup -f /data/CCBR_Pipeliner/db/PipeDB/lib/GRCh38.d1.vd1.fa \
   $bam | gzip -c > $out.pileup.gz
