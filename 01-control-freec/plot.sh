

#Visualize Control-FREEC\'s output
#If you work with Exome-seq data and you did not set printNA=FALSE, delete data points that are not in targeted regions from *_ratio.txt:
awk '$3!=-1 {print}' $outdir/$sample.pileup.gz_normal_ratio.txt > $outdir/$sample.pileup.gz_normal_ratio_noNA.txt
awk '$3!=-1 {print}' $outdir/$sample.pileup.gz_ratio.txt > $outdir/$sample.pileup.gz_ratio_noNA.txt
then use *_ratio_noNA.txt files instead of *_ratio.txt in the example below.

#You can visalize normalized copy number profile with predicted CNAs as well as BAF profile by running makeGraph.R:
cat makeGraph.R | R --slave --args < ploidy > < *_ratio.txt > [< *_BAF.txt >]



awk '$3!=-1 {print}' /data/NHLBI_BCB/Wiestner_Lab/02-CLL_Exome/Personalis-HD-new/16-Control-FREEC/HP-9202/myPileup.pileup.gz_ratio.txt > Pre_ratio_noNA.txt
awk '$3!=-1 {print}' /data/NHLBI_BCB/Wiestner_Lab/02-CLL_Exome/Personalis-HD-new/16-Control-FREEC/HP-9251/myPileup.pileup.gz_ratio.txt > PD_ratio_noNA.txt

cp /data/NHLBI_BCB/Wiestner_Lab/02-CLL_Exome/Personalis-HD-new/16-Control-FREEC/HP-9202/myPileup.pileup.gz_BAF.txt  Pre_BAF.txt
cp /data/NHLBI_BCB/Wiestner_Lab/02-CLL_Exome/Personalis-HD-new/16-Control-FREEC/HP-9251/myPileup.pileup.gz_BAF.txt  PD_BAF.txt

cat /data/NHLBI_BCB/Wiestner_Lab/02-CLL_Exome/Personalis-HD-new/16-Control-FREEC/makeGraph.R | R --slave --args < 2 > < *_ratio_noNA > < *_BAF.txt >

########


cat sids | head -1 | while read id1 id2; do

id="${id1}_T_${id2}"
idn="${id1}_N_${id2}"

cd /data/NHLBI_BCB/Mehdi/SEQC-WG1/01_Control-FREEC/$id/
mkdir plot
awk '$3!=-1 {print}' $id.pileup.gz_normal_ratio.txt > plot/N_ratio_noNA.txt
awk '$3!=-1 {print}' $id.pileup.gz_ratio.txt > plot/T_ratio_noNA.txt

cp $idn.pileup.gz_BAF.txt  plot/N_BAF.txt
cp $id.pileup.gz_BAF.txt  plot/T_BAF.txt

cd plot
cat /data/NHLBI_BCB/Wiestner_Lab/02-CLL_Exome/Personalis-HD-new/16-Control-FREEC/makeGraph.R | R --slave --args 2  *_ratio_noNA.txt  *_BAF.txt 

done

cat sids | while read id1 id2; do

id="${id1}_T_${id2}"
idn="${id1}_N_${id2}"

cd /data/NHLBI_BCB/Mehdi/SEQC-WG1/01_Control-FREEC/$id/
mkdir -p plot
#awk '$3!=-1 {print}' $id.pileup.gz_normal_ratio.txt > 
rm -f plot/N_ratio_noNA.txt
awk '$3!=-1 {print}' $id.pileup.gz_ratio.txt > plot/T_ratio_noNA.txt

#cp $idn.pileup.gz_BAF.txt
rm -f  plot/N_BAF.txt
cp $id.pileup.gz_BAF.txt  plot/T_BAF.txt


cd plot
rm -f N_ratio_noNA.txt.log2.png
rm -f N_ratio_noNA.txt.png
cat /data/NHLBI_BCB/Wiestner_Lab/02-CLL_Exome/Personalis-HD-new/16-Control-FREEC/makeGraph.R | R --slave --args 2  *_ratio_noNA.txt  *_BAF.txt 

done


