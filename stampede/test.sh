#!/bin/bash

#SBATCH -A iPlant-Collabs
#SBATCH -N 1
#SBATCH -n 16
#SBATCH -t 00:30:00
#SBATCH -p development
#SBATCH -J test-app-name
#SBATCH --mail-type BEGIN,END,FAIL
#SBATCH --mail-user <developer>@email.arizona.edu

OUT_DIR="$SCRATCH/app-name/test"

if [[ -d $OUT_DIR ]]; then
  rm -rf $OUT_DIR
fi

mkdir -p $OUT_DIR

./run.sh $OUT_DIR
