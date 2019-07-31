#!/bin/bash

#SBATCH --partition=shared
#SBATCH --job-name=NRich.sh
#SBATCH --time=18:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=24
#SBATCH --array=1-48

######################
# Begin work section #
######################
date +%F_%T
tissue=$(sed "${SLURM_ARRAY_TASK_ID}q;d" tissuenames.txt)

echo "$tissue"
echo "Seed is set to: " && echo "$seed"
echo "M value is: " && echo $M

#date=$(date +%F_%T)
#run=$(echo ${seed}_$date)

#mkdir -p "/work-zfs/rmccoy22/aseyedi2/sqtl_permutation_backup/sqtl_nrich/${SLURM_JOB_ID}_$seed/"

ml R
ml gcc

Rscript /work-zfs/rmccoy22/aseyedi2/neanderthal-sqtl/src/primary/R/NRich.R \
  "${tissue}" \
  "/work-zfs/rmccoy22/aseyedi2/GTExWGS_VCF/GTExWGS.AF.all.txt" \
  "/work-zfs/rmccoy22/aseyedi2/sqtl_permutation_backup/all_noms/varIDs/chunks/" \
  "/work-zfs/rmccoy22/aseyedi2/neanderthal-sqtl/analysis/SPRIME/sprime_calls.txt" \
  "/work-zfs/rmccoy22/aseyedi2/sqtl_permutation_backup/${tissue}_permutations.txt" \
  "/work-zfs/rmccoy22/aseyedi2/sqtl_permutation_backup/sqtl_nrich/${tissue}_${seed}_${M}_enrichment.txt" \
  $seed \
  $M

date +%F_%T
