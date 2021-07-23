#!/bin/bash 


wdir="/data/NHLBI_BCB/Mehdi/SEQC-WG1/22-CNV-MS/07_Segmentum"
cat comparison.txt | while read  d  sid m n ; do 
echo $sid "  " $m "  " $n  
mkdir -p $wdir/$d
cd $wdir/$d
sbatch --cpus-per-task=16 \
       --time=96:00:00 \
       --mem=64g \
       -J $sid \
       -o $sid.out \
       ../sbatch-Segmentum.sh $m  $n $sid 
done


# run last step without BAF
wdir="/data/NHLBI_BCB/Mehdi/SEQC-WG1/22-CNV-MS/07_Segmentum"
cat comparison.txt | head -19 | sed '1,7d' | while read  d  sid m n ; do 
echo $sid "  " $m "  " $n  
mkdir -p $wdir/$d
cd $wdir/$d
sbatch --cpus-per-task=16 \
       --time=96:00:00 \
       --mem=64g \
       -J $sid \
       -o $sid.out \
       ../sbatch-Segmentum_partial.sh $m  $n $sid 
done










####################################################### MPMPM


# Visualization of the results in IGV

In order to visualize the results in IGV, a new file should be created containing only first 6 fields of the output file.

Example
cut -f1,2,3,4,5,6 sample_x_t.seg > IGV_sample_x_t.seg

IGV_sample_x_t.seg is now ready to be loaded in IGV.


wdir="/data/NHLBI_BCB/Mehdi/SEQC-WG1/04_Segmentum"
cat sids  | while read  m n ; do 
 sid_n="${m}_N_$n"
 sid_t="${m}_T_$n"
 cd $wdir/$sid_t
 cut -f1,2,3,4,5,6 ${sid_t}_11_0.7_0.3.seg > IGV_${sid_t}.seg
done


# Extracting copy neutral LOH regions

In order to extract copy neutral LOH regions from the output(s) use the following command:

Segmentum find recurrent cnLOHs <seg_files>... [-c N] [-t N]  
    
Options:  
    -c --clogr_thresh=N   Coverage logratio must be below this threshold to call a copy neutral LOH region [default: 0.1]    
    -t --baf_thresh=N     B-allele fraction must be below this threshold to call a copy neutral LOH region [default: 0.15]   

Example
Segmentum find recurrent cnLOHs sample_x_t.seg
Segmentum find recurrent cnLOHs sample_x_t.seg sample_y_t.seg sample_z_t.seg #in case of more samples

Segmentum find recurrent cnLOHs ${sid_t}_11_0.7_0.3.seg










############################# rerun
sid_n="WGS_LL_N_1.bwa"
sid_t="WGS_LL_T_1.bwa"

wdir="/data/NHLBI_BCB/Mehdi/SEQC-WG1/04_Segmentum"

sbatch --cpus-per-task=16 \
       --time=96:00:00 \
       --mem=64g \
       -J $sid_t \
       -o $sid_t.out \
       /data/NHLBI_BCB/Mehdi/SEQC-WG1/04_Segmentum/sbatch-Segmentum.sh $sid_n  $sid_t 


######################### from KVM-titan

sid_n="WGS_EA_N_1.bwa"
sid_t="WGS_EA_T_1.bwa"


wdir="/run/user/1000/gvfs/sftp:host=helix.nih.gov,user=piroozniam2/home/piroozniam2/NHLBI_BCB/Mehdi/SEQC-WG1/04_Segmentum_/WGS_EA_T_1.bwa"

/home/titan/Data/Segmentum/Segmentum-master/bin/Segmentum  \
  analyze with BAF  $wdir/$sid_t.wig.gz    $wdir/$sid_n.wig.gz   $wdir/B_allele_fraction.tsv.gz   11   0.7   0.3  -p False

sid_n="WGS_EA_N_1.bwa"
sid_t="WGS_EA_T_1.bwa"

wdir="/home/titan/Data/Segmentum/test"

/home/titan/Data/Segmentum/Segmentum-master/bin/Segmentum  \
  analyze with BAF  $wdir/$sid_t.wig.gz    $wdir/$sid_n.wig.gz   $wdir/B_allele_fraction.$sid.tsv.gz   11   0.7   0.3  -p False




######################### additional TP and WES

wdir="/data/NHLBI_BCB/Mehdi/SEQC-WG1/22-CNV-MS/07_Segmentum"
cat comparison_2.txt | while read  d  sid m n ; do 
echo $sid "  " $m "  " $n  
mkdir -p $wdir/$d
cd $wdir/$d
sbatch --cpus-per-task=16 \
       --time=96:00:00 \
       --mem=64g \
       -J $sid \
       -o $sid.out \
       ../sbatch-Segmentum.sh $m  $n $sid 
done


wdir="/data/NHLBI_BCB/Mehdi/SEQC-WG1/22-CNV-MS/07_Segmentum"
cat comparison_2.txt | while read  d  sid m n ; do 
echo $sid "  " $m "  " $n  
mkdir -p $wdir/$d
cd $wdir/$d
sbatch --cpus-per-task=16 \
       --time=96:00:00 \
       --mem=64g \
       -J $sid \
       -o $sid.out \
       ../sbatch-Segmentum_partial.sh $m  $n $sid 
done







