#!/bin/bash
set -e        # stop the script if a command fails

function fail {
    echo "FAIL: $@" >&2
    exit 1  # signal failure
}


echo -e "Start at `date +"%Y/%m/%d %H:%M:%S"`" 1>&2

module load samtools
module load R
module load bedtools
module load sambamba
module load freec

ulimit -u 8192

freec  -conf  $1

#export freec113="/data/NHLBI_BCB/bin/FREEC/freec"
#$freec113  -conf  $1






