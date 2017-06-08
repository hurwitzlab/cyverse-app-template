#!/bin/bash

$OUT_DIR=$1

module load singularity

export LAUNCHER_DIR="$HOME/src/launcher"
export LAUNCHER_PLUGIN_DIR=$LAUNCHER_DIR/plugins
export LAUNCHER_WORKDIR=$OUT_DIR
export LAUNCHER_RMI=SLURM

export LAUNCHER_JOB_FILE=`pwd`/launcher_jobfile
echo ${LAUNCHER_JOB_FILE}
singularity run app-name.img

$LAUNCHER_DIR/paramrun
echo "Ended launcher"
