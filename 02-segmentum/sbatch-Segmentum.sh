#!/bin/bash
set -e        # stop the script if a command fails

function fail {
    echo "FAIL: $@" >&2
    exit 1  # signal failure
}


n=$1    
t=$2    
sid=$3
 
echo -e "Start at `date +"%Y/%m/%d %H:%M:%S"`" 1>&2

module load samtools
module load R
module load python/3.5


export PATH=/data/NHLBI_BCB/bin/Segmentum-master/bin:$PATH   

# 1) Creating the input files from BAM files

Segmentum extract read depth $n 2000 | gzip -c > $sid.n.wig.gz
Segmentum extract read depth $t 2000 | gzip -c > $sid.t.wig.gz

# 2) create the B-allele-fraction file,

Segmentum calculate BAF \
  /data/CCBR_Pipeliner/db/PipeDB/lib/GRCh38.d1.vd1.fa \
  /data/NHLBI_BCB/bin/Segmentum-master/hg38_snp144.SingleDiNucl.tsv \
  $t $n --hetz=4:0.3 -q20 | gzip -c > B_allele_fraction.$sid.tsv.gz


# 3) Analysze

## with BAF
# Segmentum analyze with BAF <tumor> <normal> <BAF_file> <window_size> <clogr_threshold> <BAF_threshold> [-m N] [-l N] [-b N] [-p N] [-B N]     

Segmentum analyze with BAF  $sid.t.wig.gz    $sid.n.wig.gz   B_allele_fraction.$sid.tsv.gz   11   0.7   0.3  -p False

#    -m --min_read=N       Minimum number of reads from the normal sample to calculate the coverage log ratio [default: 50]  
#    -l --logr_merge=N     Log ratio segments merging threshold [default: 0.15]  
#    -b --baf_merge=N      B-allele fraction segments merging threshold [default: 0.05] 
#    -p --print=N          If true, prints the results to standard output, otherwise to a file with the same name as the sample name [default: True]    
#    -B --BAF=N            If true, creates a .WIG file for heterozygous SNP allele fractions to be opened in IGV [default: True]    
 

export PATH=$PATH:/data/NHLBI_BCB/bin/Segmentum-master2/Segmentum/bin   
Segmentum analyze with BAF  TP_5p_100x.t.wig.gz    TP_5p_100x.n.wig.gz   B_allele_fraction.TP_5p_100x.tsv.gz   11   0.7   0.3  -p False
Segmentum analyze with BAF  TP_20p_10X.t.wig.gz    TP_20p_10X.n.wig.gz   B_allele_fraction.TP_20p_10X.tsv.gz   11   0.7   0.3  -p False


/data/bin/Segmentum/bin/Segmentum analyze with BAF  TP_20p_10X.t.wig.gz    TP_20p_10X.n.wig.gz   B_allele_fraction.TP_20p_10X.tsv.gz   11   0.7   0.3  -p False




