#!/bin/bash 


wdir="/data/NHLBI_BCB/Mehdi/SEQC-WG1/22-CNV-MS/06_Control-FREEC"
# first 4 files WGS
cat $wdir/comparison_Freec.txt  | head -4 | while read  mainfolder label_noneed subfolder n t ; do 
echo $t "  " $n  
cd $wdir/$mainfolder
cat $wdir/config_WGS_template.txt | sed "s/samplepileup/$t.pileup.gz/g" | sed "s/controlpileup/$n.pileup.gz/g" > config_$t.txt
sbatch --cpus-per-task=8 \
       --time=96:00:00 \
       --mem=222g \
       -J $t \
       -o $t.out \
       $wdir/sbatch-FREEC.sh config_$t.txt
done

# WES files
wdir="/data/NHLBI_BCB/Mehdi/SEQC-WG1/22-CNV-MS/06_Control-FREEC"
cd $wdir/02_FFPE_WES
cat /data/NHLBI_BCB/Mehdi/SEQC-WG1/21-WES-CNV/01-bams/target_merged.bed | grep -v 'chrUn\|_random'  > target_merged.bed
sbatch --cpus-per-task=8 --time=96:00:00  --mem=222g -J WES1 -o WES1.out $wdir/sbatch-FREEC.sh config_WES1.txt
sbatch --cpus-per-task=8 --time=96:00:00  --mem=222g -J WES2 -o WES2.out $wdir/sbatch-FREEC.sh config_WES2.txt
sbatch --cpus-per-task=8 --time=96:00:00  --mem=222g -J WES3 -o WES3.out $wdir/sbatch-FREEC.sh config_WES3.txt


echo "# make link to normals
for i in 20 50 100; do
cd /data/NHLBI_BCB/Mehdi/SEQC-WG1/22-CNV-MS/06_Control-FREEC/03_Tumor_Purity/${i}_purity
ln -s /data/NHLBI_BCB/Mehdi/SEQC-WG1/22-CNV-MS/06_Control-FREEC/03_Tumor_Purity/normals/SPP_GT_0-1_1.bwa.dedup.bam.pileup.gz        SPP_GT_0-1_1.bwa.dedup.bam.pileup.gz
ln -s /data/NHLBI_BCB/Mehdi/SEQC-WG1/22-CNV-MS/06_Control-FREEC/03_Tumor_Purity/normals/SPP_GT_0-1_1.bwa.dedup.s0.1.bam.pileup.gz   SPP_GT_0-1_1.bwa.dedup.s0.1.bam.pileup.gz
ln -s /data/NHLBI_BCB/Mehdi/SEQC-WG1/22-CNV-MS/06_Control-FREEC/03_Tumor_Purity/normals/SPP_GT_0-1_1.bwa.dedup.s0.5.bam.pileup.gz   SPP_GT_0-1_1.bwa.dedup.s0.5.bam.pileup.gz
ln -s /data/NHLBI_BCB/Mehdi/SEQC-WG1/22-CNV-MS/06_Control-FREEC/03_Tumor_Purity/normals/SPP_GT_0-1_mergeTwo.RG.bwa.bam.pileup.gz    SPP_GT_0-1_mergeTwo.RG.bwa.bam.pileup.gz
done
" > /dev/null

# rest
wdir="/data/NHLBI_BCB/Mehdi/SEQC-WG1/22-CNV-MS/06_Control-FREEC"
cat $wdir/comparison_Freec.txt  | sed '1,7d' | while read  mainfolder label_noneed subfolder n t ; do 
echo $t "  " $n  
cd $wdir/$mainfolder/$subfolder
cat $wdir/config_WGS_template.txt | sed "s/samplepileup/$t.pileup.gz/g" | sed "s/controlpileup/$n.pileup.gz/g" > config_$t.txt
sbatch --cpus-per-task=8 \
       --time=96:00:00 \
       --mem=222g \
       -J $t \
       -o $t.out \
       $wdir/sbatch-FREEC.sh config_$t.txt
done


#       --partition=largemem  \

##################### step 2

wdir="/data/NHLBI_BCB/Mehdi/SEQC-WG1/22-CNV-MS/06_Control-FREEC"
# first 4 files WGS
cat $wdir/comparison_Freec.txt  | head -4 | while read  mainfolder label_noneed subfolder n t ; do 
echo $t "  " $n  
cd $wdir/$mainfolder
cat $wdir/config_WGS_template_step2.txt | sed "s/samplepileup/$t.pileup.gz/g" | sed "s/controlpileup/$n.pileup.gz/g" > config_$t.2.txt

cat $n.pileup.gz_control.cpn | grep -v '_\|EBV\|M' > $n.pileup.gz_control.m.cpn
cat $t.pileup.gz_sample.cpn  | grep -v '_\|EBV\|M' > $t.pileup.gz_sample.m.cpn

sbatch --cpus-per-task=8 \
       --time=96:00:00 \
       --mem=222g \
       -J $t \
       -o $t.out \
       $wdir/sbatch-FREEC.sh config_$t.2.txt
done




wdir="/data/NHLBI_BCB/Mehdi/SEQC-WG1/22-CNV-MS/06_Control-FREEC"
cd $wdir/02_FFPE_WES
sbatch --cpus-per-task=8 --time=96:00:00  --mem=222g -J WES1 -o WES1.out $wdir/sbatch-FREEC.sh config_WES1.txt
sbatch --cpus-per-task=8 --time=96:00:00  --mem=222g -J WES2 -o WES2.out $wdir/sbatch-FREEC.sh config_WES2.txt
sbatch --cpus-per-task=8 --time=96:00:00  --mem=222g -J WES3 -o WES3.out $wdir/sbatch-FREEC.sh config_WES3.txt


wdir="/data/NHLBI_BCB/Mehdi/SEQC-WG1/22-CNV-MS/06_Control-FREEC"
cat $wdir/comparison_Freec.txt  | sed '1,7d' | while read  mainfolder label_noneed subfolder n t ; do 
echo $t "  " $n  
cd $wdir/$mainfolder/$subfolder
cat $wdir/config_WGS_template_step2.txt | sed "s/samplepileup/$t.pileup.gz/g" | sed "s/controlpileup/$n.pileup.gz/g" > config_$t.2.txt
cat $n.pileup.gz_control.cpn | grep -v '_\|EBV\|M' > $n.pileup.gz_control.m.cpn
cat $t.pileup.gz_sample.cpn  | grep -v '_\|EBV\|M' > $t.pileup.gz_sample.m.cpn

sbatch --cpus-per-task=8 \
       --time=96:00:00 \
       --mem=222g \
       -J $t \
       -o $t.out \
       $wdir/sbatch-FREEC.sh config_$t.2.txt
done


wdir="/data/NHLBI_BCB/Mehdi/SEQC-WG1/22-CNV-MS/06_Control-FREEC"
cat $wdir/comparison_Freec_2.txt | while read  mainfolder label_noneed subfolder n t ; do 
echo $n "  " $t  
cd $wdir/$mainfolder/$subfolder
cat $wdir/config_WGS_template_step2.txt | sed "s/samplepileup/$t.pileup.gz/g" | sed "s/controlpileup/$n.pileup.gz/g" > config_$t.2.txt
cat $n.pileup.gz_control.cpn | grep -v '_\|EBV\|M' > $n.pileup.gz_control.m.cpn
cat $t.pileup.gz_sample.cpn  | grep -v '_\|EBV\|M' > $t.pileup.gz_sample.m.cpn

sbatch --cpus-per-task=8 \
       --time=96:00:00 \
       --mem=222g \
       -J $t \
       -o $t.out \
       $wdir/sbatch-FREEC.sh config_$t.2.txt
done


################################################ TP

# make link to normals
for i in 5 10 20 50 75 100; do
cd /data/NHLBI_BCB/Mehdi/SEQC-WG1/22-CNV-MS/06_Control-FREEC/03_Tumor_Purity/${i}_purity
ln -s /data/NHLBI_BCB/Mehdi/SEQC-WG1/22-CNV-MS/06_Control-FREEC/03_Tumor_Purity/normals/SPP_GT_0-1_1.bwa.dedup.bam.pileup.gz            SPP_GT_0-1_1.bwa.dedup.bam.pileup.gz
ln -s /data/NHLBI_BCB/Mehdi/SEQC-WG1/22-CNV-MS/06_Control-FREEC/03_Tumor_Purity/normals/SPP_GT_0-1_1.bwa.dedup.s0.1.bam.pileup.gz       SPP_GT_0-1_1.bwa.dedup.s0.1.bam.pileup.gz
ln -s /data/NHLBI_BCB/Mehdi/SEQC-WG1/22-CNV-MS/06_Control-FREEC/03_Tumor_Purity/normals/SPP_GT_0-1_1.bwa.dedup.s0.3.bam.pileup.gz       SPP_GT_0-1_1.bwa.dedup.s0.3.bam.pileup.gz
ln -s /data/NHLBI_BCB/Mehdi/SEQC-WG1/22-CNV-MS/06_Control-FREEC/03_Tumor_Purity/normals/SPP_GT_0-1_1.bwa.dedup.s0.5.bam.pileup.gz       SPP_GT_0-1_1.bwa.dedup.s0.5.bam.pileup.gz
ln -s /data/NHLBI_BCB/Mehdi/SEQC-WG1/22-CNV-MS/06_Control-FREEC/03_Tumor_Purity/normals/SPP_GT_0-1_1.bwa.dedup.s0.8.bam.pileup.gz       SPP_GT_0-1_1.bwa.dedup.s0.8.bam.pileup.gz
ln -s /data/NHLBI_BCB/Mehdi/SEQC-WG1/22-CNV-MS/06_Control-FREEC/03_Tumor_Purity/normals/SPP_GT_0-1_mergeThree.RG.bwa.bam.pileup.gz      SPP_GT_0-1_mergeThree.RG.bwa.bam.pileup.gz
ln -s /data/NHLBI_BCB/Mehdi/SEQC-WG1/22-CNV-MS/06_Control-FREEC/03_Tumor_Purity/normals/SPP_GT_0-1_mergeTwo.RG.bwa.bam.pileup.gz        SPP_GT_0-1_mergeTwo.RG.bwa.bam.pileup.gz
done

# run step 1
wdir="/data/NHLBI_BCB/Mehdi/SEQC-WG1/22-CNV-MS/06_Control-FREEC"
cat $wdir/comparison_Freec_TP.txt  | while read  mainfolder label_noneed subfolder n t ; do 
echo $t "  " $n  
cd $wdir/$mainfolder/$subfolder
cat $wdir/config_WGS_template.txt | sed "s/samplepileup/$t/g" | sed "s/controlpileup/$n/g" > config_$t.txt
sbatch --cpus-per-task=8 \
       --time=96:00:00 \
       --mem=222g \
       -J $t \
       -o $t.out \
       $wdir/sbatch-FREEC.sh config_$t.txt
done



# step 2 (need to run)
wdir="/data/NHLBI_BCB/Mehdi/SEQC-WG1/22-CNV-MS/06_Control-FREEC"
cat $wdir/comparison_Freec_TP.txt | while read  mainfolder label_noneed subfolder n t ; do 
echo $n "  " $t  
cd $wdir/$mainfolder/$subfolder
cat $wdir/config_WGS_template_step2.txt | sed "s/samplepileup/$t/g" | sed "s/controlpileup/$n/g" > config_$t.2.txt
cat ${n}_control.cpn | grep -v '_\|EBV\|M' > ${n}_control.m.cpn
cat ${t}_sample.cpn  | grep -v '_\|EBV\|M' > ${t}_sample.m.cpn
sbatch --cpus-per-task=8 \
       --time=96:00:00 \
       --mem=222g \
       -J $t \
       -o $t.out \
       $wdir/sbatch-FREEC.sh config_$t.2.txt
done





wdir="/data/NHLBI_BCB/Mehdi/SEQC-WG1/22-CNV-MS/06_Control-FREEC"
cat $wdir/tmp1 | while read  mainfolder label_noneed subfolder n t ; do 
echo $n "  " $t  
cd $wdir/$mainfolder/$subfolder
cat $wdir/config_WGS_template_step2.txt | sed "s/samplepileup/$t/g" | sed "s/controlpileup/$n/g" > config_$t.2.txt
cat ${n}_control.cpn | grep -v '_\|EBV\|M' > ${n}_control.m.cpn
cat ${t}_sample.cpn  | grep -v '_\|EBV\|M' > ${t}_sample.m.cpn
sbatch --cpus-per-task=8 \
       --time=96:00:00 \
       --mem=222g \
       -J $t \
       -o $t.out \
       $wdir/sbatch-FREEC.sh config_$t.2.txt
done




# redo LBP
wdir="/data/NHLBI_BCB/Mehdi/SEQC-WG1/22-CNV-MS/06_Control-FREEC"
cat $wdir/tmp2 | while read  mainfolder label_noneed subfolder n t ; do 
echo $n "  " $t  
cd $wdir/$mainfolder/$subfolder
#cat $wdir/config_WGS_template_step2.txt | sed "s/samplepileup/$t/g" | sed "s/controlpileup/$n/g" > config_$t.2.txt
#cat ${n}_control.cpn | grep -v '_\|EBV\|M' > ${n}_control.m.cpn
#cat ${t}_sample.cpn  | grep -v '_\|EBV\|M' > ${t}_sample.m.cpn
sbatch --cpus-per-task=8 \
       --time=96:00:00 \
       --mem=222g \
       -J $t \
       -o $t.out \
       $wdir/sbatch-FREEC.sh config_$t.2.txt
done




############# WES

# WES files (only one step)

wdir="/data/NHLBI_BCB/Mehdi/SEQC-WG1/22-CNV-MS/06_Control-FREEC"
cat $wdir/comparison_Freec_WES.txt  | while read  mainfolder n t ; do 
echo $t "  " $n  
cd $wdir/$mainfolder
cat $wdir/$mainfolder/config_WES_template.txt | sed "s/tumor_pileup_gz/$t.bwa.dedup.bam.pileup.gz/g" | sed "s/normal_pileup_gz/$n.bwa.dedup.bam.pileup.gz/g" > config_$t.txt
sbatch --cpus-per-task=8 \
       --time=96:00:00 \
       --mem=222g \
       -J $t \
       -o $t.out \
       $wdir/sbatch-FREEC.sh config_$t.txt
done







