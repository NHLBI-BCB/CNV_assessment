
###############################################################################
#
#
# Generating the SNP pileup files needed for running FACETS
#
#
###############################################################################


mlocal="/run/user/200199727/gvfs/sftp:host=helix.nih.gov"
cat comparison.txt  | while read  d sid n t ; do 
 echo $sid " " $n "  " $t  
 vcffile="$mlocal/data/NHLBI_BCB/bin/facets/Homo_sapiens_assembly38.dbsnp138.vcf.gz"
 outputfile="$sid"
 normalbam="$mlocal/$n"
 tumorbam="$mlocal/$t"
 mkdir -p $mlocal/data/NHLBI_BCB/Mehdi/SEQC-WG1/22-CNV-MS/08_FACET/$d/$sid
 cd $mlocal/data/NHLBI_BCB/Mehdi/SEQC-WG1/22-CNV-MS/08_FACET/$d/$sid
 snp-pileup -g -q15 -Q20 -P100 -r25,0 $vcffile $outputfile $normalbam $tumorbam &
done


# fix the n t swap 
#wdir="/data/NHLBI_BCB/Mehdi/SEQC-WG1/22-CNV-MS/08_FACET/03_Tumor_Purity"

wdir1="/run/user/200199727/gvfs/sftp:host=helix.nih.gov/data/NHLBI_BCB/Mehdi/SEQC-WG1/22-CNV-MS/08_FACET/03_Tumor_Purity_"
wdir2="/run/user/200199727/gvfs/sftp:host=helix.nih.gov/data/NHLBI_BCB/Mehdi/SEQC-WG1/22-CNV-MS/08_FACET/03_Tumor_Purity"

for i in TP_100p_100X TP_100p_10X TP_100p_200X TP_100p_50X TP_20p_100X TP_20p_10X TP_20p_200X TP_20p_50X TP_50p_100X TP_50p_10X TP_50p_200X TP_50p_50X; do
mkdir -p $wdir2/$i
zcat $wdir1/$i/$i.gz | sed 's/,/\t/g' | awk -F'\t' '{if ($1 == Chromosome) {print "Chromosome,Position,Ref,Alt,File1R,File1A,File1E,File1D,File2R,File2A,File2E,File2D"} else {print $1"\t"$2"\t"$3"\t"$4"\t"$9"\t"$10"\t"$11"\t"$12"\t"$5"\t"$6"\t"$7"\t"$8}}' |  sed 's/\t/,/g' | bgzip -c  > $wdir2/$i/$i.gz &
done
wait


################ additional TP and WES
 
mlocal="/run/user/200199727/gvfs/sftp:host=helix.nih.gov"
cat comparison_2.txt  | while read  d sid n t ; do 
 echo $sid " " $n "  " $t  
 vcffile="$mlocal/data/NHLBI_BCB/bin/facets/Homo_sapiens_assembly38.dbsnp138.vcf.gz"
 outputfile="$sid"
 normalbam="$mlocal/$n"
 tumorbam="$mlocal/$t"
 mkdir -p $mlocal/data/NHLBI_BCB/Mehdi/SEQC-WG1/22-CNV-MS/08_FACET/$d/$sid
 cd $mlocal/data/NHLBI_BCB/Mehdi/SEQC-WG1/22-CNV-MS/08_FACET/$d/$sid
 snp-pileup -g -q15 -Q20 -P100 -r25,0 $vcffile $outputfile $normalbam $tumorbam &
done


# step 2
scriptdir="/data/NHLBI_BCB/Mehdi/SEQC-WG1/22-CNV-MS/08_FACET"
run=1

cat comparison_2.txt  | sed '1,1d' | while read  d sid n t ; do 
 echo $sid " " $n "  " $t  
 sbatch --job-name="${sid}.$d.${run}" \
        --partition=norm \
        --time=2:00:00 \
        --mem=32g \
        --cpus-per-task=4 \
        --error="${scriptdir}/$d/${sid}/${sid}.run.${run}.slurm.err.txt" \
        --output="${scriptdir}/$d/${sid}/${sid}.run.${run}.slurm.out.txt" \
        $scriptdir/sbatch-runfacets.sh $d ${sid}
done 









