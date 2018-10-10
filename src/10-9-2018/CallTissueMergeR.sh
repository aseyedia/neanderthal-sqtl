#!/bin/bash

#SBATCH --partition=shared
#SBATCH --job-name=TissueMerge
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1

######################
# Begin work section #
######################

module load gcc/5.5.0
module load R # default is 3.5
module list
which R # should give absolute path

for file in altrans/*
do
    Rscript --vanilla TissueMerge.R "$file" matches/EASmatch.txt
    Rscript --vanilla TissueMerge.R "$file" matches/SASmatch.txt
    Rscript --vanilla TissueMerge.R "$file" matches/EURmatch.txt
done



