#!/bin/bash 


#ll /data/NHLBI_BCB/Wiestner_Lab/02-CLL_Exome/Personalis-HD-new/01-BAMs/*/DNA_Pipeline/Alignments/DNA_*_tumor_dna_aligned_recal.sorted.bam


#a=/tmp/xx/file.tar.gz
#xpath=${a%/*} 
#xbase=${a##*/}
#xfext=${xbase##*.}
#xpref=${xbase%.*}
#echo ;echo path=${xpath};echo base=${xbase};echo pref=${xpref};echo ext=${xfext}

#######################################################################################################
#
#
# Create pileups from the BAM files for FREEC input using the GDC reference
# https://gdc.cancer.gov/about-data/gdc-data-processing/gdc-reference-files
#
#
#######################################################################################################

cat bams_01  | while read  b ; do 
xbase=${b##*/}
out="/data/NHLBI_BCB/Mehdi/SEQC-WG1/22-CNV-MS/06_Control-FREEC/01_FFPE_WGS"
sbatch --cpus-per-task=16   --time=96:00:00  --mem=64g -J $xbase -o $xbase.out sbatch-pileup.sh   $b  $out/$xbase
done

cat bams_02  | while read  b ; do 
xbase=${b##*/}
out="/data/NHLBI_BCB/Mehdi/SEQC-WG1/22-CNV-MS/06_Control-FREEC/02_FFPE_WES"
sbatch --cpus-per-task=16   --time=96:00:00  --mem=64g -J $xbase -o $xbase.out sbatch-pileup.sh   $b  $out/$xbase
done

cat bams_3  | while read  p b ; do 
xbase=${b##*/}
out="/data/NHLBI_BCB/Mehdi/SEQC-WG1/22-CNV-MS/06_Control-FREEC/03_Tumor_Purity/$p"
mkdir -p $out
sbatch --cpus-per-task=16   --time=96:00:00  --mem=64g -J $xbase -o $xbase.out sbatch-pileup.sh   $b  $out/$xbase
done

cat bams_3_normals  | while read  p b ; do 
xbase=${b##*/}
out="/data/NHLBI_BCB/Mehdi/SEQC-WG1/22-CNV-MS/06_Control-FREEC/03_Tumor_Purity/$p"
mkdir -p $out
sbatch --cpus-per-task=16   --time=96:00:00  --mem=64g -J $xbase -o $xbase.out sbatch-pileup.sh   $b  $out/$xbase
done

cat bams_04_1  | while read  b ; do 
xbase=${b##*/}
out="/data/NHLBI_BCB/Mehdi/SEQC-WG1/22-CNV-MS/06_Control-FREEC/04_LBP/1ng"
mkdir -p $out
sbatch --cpus-per-task=16   --time=96:00:00  --mem=64g -J $xbase -o $xbase.out sbatch-pileup.sh   $b  $out/$xbase
done

cat bams_04_10  | while read  b ; do 
xbase=${b##*/}
out="/data/NHLBI_BCB/Mehdi/SEQC-WG1/22-CNV-MS/06_Control-FREEC/04_LBP/10ng"
mkdir -p $out
sbatch --cpus-per-task=16   --time=96:00:00  --mem=64g -J $xbase -o $xbase.out sbatch-pileup.sh   $b  $out/$xbase
done

cat bams_04_100  | while read  b ; do 
xbase=${b##*/}
out="/data/NHLBI_BCB/Mehdi/SEQC-WG1/22-CNV-MS/06_Control-FREEC/04_LBP/100ng"
mkdir -p $out
sbatch --cpus-per-task=16   --time=96:00:00  --mem=64g -J $xbase -o $xbase.out sbatch-pileup.sh   $b  $out/$xbase
done


################################################### additional TP

cat bams_3_normals | sed '1,5d'  | while read  p b ; do 
xbase=${b##*/}
out="/data/NHLBI_BCB/Mehdi/SEQC-WG1/22-CNV-MS/06_Control-FREEC/03_Tumor_Purity/$p"
mkdir -p $out
sbatch --cpus-per-task=16   --time=96:00:00  --mem=64g -J $xbase -o $xbase.out sbatch-pileup.sh   $b  $out/$xbase
done

# redo bams_3 all together
cat bams_3  | while read  p b ; do 
xbase=${b##*/}
out="/data/NHLBI_BCB/Mehdi/SEQC-WG1/22-CNV-MS/06_Control-FREEC/03_Tumor_Purity/$p"
mkdir -p $out
sbatch --cpus-per-task=16   --time=96:00:00  --mem=64g -J $xbase -o $xbase.out sbatch-pileup.sh   $b  $out/$xbase
done

cat bams_5  | while read  b ; do 
xbase=${b##*/}
out="/data/NHLBI_BCB/Mehdi/SEQC-WG1/22-CNV-MS/06_Control-FREEC/05_WES"
sbatch --cpus-per-task=16   --time=96:00:00  --mem=64g -J $xbase -o $xbase.out sbatch-pileup.sh   $b  $out/$xbase
done











