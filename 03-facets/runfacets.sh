#!/bin/sh -l
#$ -cwd

scriptdir="/data/NHLBI_BCB/Mehdi/SEQC-WG1/22-CNV-MS/08_FACET"
run=1

cat comparison.txt  | while read  d sid n t ; do 
 echo $sid " " $n "  " $t  
 sbatch --job-name="${sid}.$d.${run}" \
        --partition=norm \
        --time=4:00:00 \
        --mem=32g \
        --cpus-per-task=4 \
        --error="${scriptdir}/$d/${sid}/${sid}.run.${run}.slurm.err.txt" \
        --output="${scriptdir}/$d/${sid}/${sid}.run.${run}.slurm.out.txt" \
        $scriptdir/sbatch-runfacets.sh $d ${sid}
done 


