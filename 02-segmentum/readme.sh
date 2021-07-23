

wget https://github.com/eafyounian/Segmentum/archive/master.zip   
unzip master.zip   
cd Segmentum-master/    
make   

export PATH=/data/NHLBI_BCB/bin/Segmentum-master/bin:$PATH   

module load python/3.5

Segmentum

"
A tool for copy number analysis and segmenting the cancer genome.

Usage:
  Segmentum extract read depth <BAM_file> <window_size> [-q N] 
  Segmentum calculate BAF <genome_fasta> <SNP_position> <tumor> <normal> [--hetz=N:R] [-q N] [-r REGION]
  Segmentum plot <tumor> <normal> <BAF_file> <window_size>  [-m N]
  Segmentum analyze with BAF <tumor> <normal> <BAF_file> <window_size> <clogr_threshold> <BAF_threshold> [-m N] [-l N] [-b N] [-p N] [-B N]
  Segmentum analyze without BAF <tumor> <normal> <window_size> <clogr_threshold> [-m N] [-l N] [-p N]
  Segmentum find recurrent cnLOHs <seg_files>... [-c N] [-t N]
  Segmentum simulate <normal> [-P N] [-O N] [-L N]
  
Options:
  -h --help             Show this screen.
  -m --min_read=N       Minimum number of reads from the normal sample to calculate the coverage log ratio [default: 50]
  -l --logr_merge=N     Log ratio segments merging threshold [default: 0.15]
  -b --baf_merge=N      B-allele fraction segments merging threshold [default: 0.05]
  -q --quality=N        Minimum mapping quality [default: 10]
  -r <region>           Restrict analysis to chromosomal region
  --hetz=N:R            Minimum evidence for heterozygous [default: 4:0.3]
  -c --clogr_thresh=N   Coverage logratio must be below this threshold to call a copy neutral LOH region [default: 0.1]
  -t --baf_thresh=N     B-allele fraction must be below this threshold to call a copy neutral LOH region [default: 0.15]
  -p --print=N          If true, prints the results to standard output, otherwise to a file with the same name as the sample name [default: True]
  -B --BAF=N            If true, creates a .WIG file for heterozygous SNP allele fractions to be opened in IGV [default: True]
  -P --tumor_purity=N   (1 - fraction) of normal contamination [default: 0.7]
  -O --output_prefix=N  prefix to be assigned to the simulated files [default: simulated]
  -L --read_length=N    read length to be considered for simulation [default: 150]
"
####
    
# https://github.com/eafyounian/Segmentum


# 1) Creating the input files from BAM files

Segmentum extract read depth sample_x_t.bam 2000 | gzip -c > sample_x_t.wig.gz
Segmentum extract read depth sample_x_n.bam 2000 | gzip -c > sample_x_n.wig.gz

# 2) create the B-allele-fraction file,

Segmentum calculate BAF hg19.fa hg19_1000g_2014oct_SNPs.tsv.gz sample_x_t.bam sample_x_n.bam --hetz=4:0.3 -q20 | gzip -c > B_allele_fraction.tsv.gz

# hg19_1000g_2014oct_SNPs.tsv.gz
chr     position
1       10177  
1       10235  
1       10352  

echo -e "chr\tposition" > hg38_snp144.SingleDiNucl.tsv
cat /data/NHLBI_BCB/bin/FREEC/hg38_snp144.SingleDiNucl.1based.txt | cut -f -2   >> hg38_snp144.SingleDiNucl.tsv
cat hg38_snp144.SingleDiNucl.tsv | bgzip -c >  hg38_snp144.SingleDiNucl.tsv.gz

# 3) Analysze

## with BAF
Segmentum analyze with BAF <tumor> <normal> <BAF_file> <window_size> <clogr_threshold> <BAF_threshold> [-m N] [-l N] [-b N] [-p N] [-B N]     

## without BAF
Segmentum analyze without BAF <tumor> <normal> <window_size> <clogr_threshold> [-m N] [-l N]  

Options:  
    -h --help             Show this screen
    -m --min_read=N       Minimum number of reads from the normal sample to calculate the coverage log ratio [default: 50]  
    -l --logr_merge=N     Log ratio segments merging threshold [default: 0.15]  
    -b --baf_merge=N      B-allele fraction segments merging threshold [default: 0.05] 
    -p --print=N          If true, prints the results to standard output, otherwise to a file with the same name as the sample name [default: True]    
    -B --BAF=N            If true, creates a .WIG file for heterozygous SNP allele fractions to be opened in IGV [default: True]    



# 4) Visualization of the results in IGV

In order to visualize the results in IGV, a new file should be created containing only first 6 fields of the output file.

Example
cut -f1,2,3,4,5,6 sample_x_t.seg > IGV_sample_x_t.seg

IGV_sample_x_t.seg is now ready to be loaded in IGV.


# 4) Extracting copy neutral LOH regions

In order to extract copy neutral LOH regions from the output(s) use the following command:

Segmentum find recurrent cnLOHs <seg_files>... [-c N] [-t N]  
    
Options:  
    -c --clogr_thresh=N   Coverage logratio must be below this threshold to call a copy neutral LOH region [default: 0.1]    
    -t --baf_thresh=N     B-allele fraction must be below this threshold to call a copy neutral LOH region [default: 0.15]   

Example
Segmentum find recurrent cnLOHs sample_x_t.seg
Segmentum find recurrent cnLOHs sample_x_t.seg sample_y_t.seg sample_z_t.seg #in case of more samples


######################### from KVM-titan
/home/titan/Data/Segmentum/Segmentum-master/bin/Segmentum  






