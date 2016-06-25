#!/bin/bash

#SBATCH --job-name=EffectSizes
#SBATCH --output=error/out.EffectSizes
#SBATCH --error=error/err.EffectSizes
#SBATCH --time=24:00:00
#SBATCH --nodes=11
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=8
#SBATCH --partition=russpold
#SBATCH --qos=russpold

ConnectomeInABoxDir=$HCPDIR

# Experiment to be analyzed
Paradigms=("tfMRI_MOTOR" "tfMRI_WM" "tfMRI_EMOTION" "tfMRI_GAMBLING" "tfMRI_LANGUAGE" "tfMRI_SOCIAL" "tfMRI_RELATIONAL")
Paradigm_name=("MOTOR" "WM" "EMOTION" "GAMBLING" "LANGUAGE" "SOCIAL" "RELATIONAL")

Contrasts=(26 30 6 6 6 6 6)

# Working Directory
HomeDir=/home/jdurnez/effect_sizes/
WorkDir=/scratch/users/jdurnez/effect_sizes/
OutDir=/scratch/users/jdurnez/effect_sizes/EffectSizes/

# File with subjects to be included and disks on which they appear
SubjectsFile=$HomeDir/SubjectSelection/IDs_all_cons_and_unrelated.txt

for exp in {0..5} ; do

  for con in $(seq 1 ${Contrasts[exp]}); do
      echo $con

      ConDir=$WorkDir/GroupAnalyses/tfMRI_${Paradigm_name[exp]}/Contrast_$con

      # Extract Effectsizes
      python $HomeDir/EffectSize/EffectSize.py ${Paradigm_name[exp]} $con $ConDir $WorkDir

  done

done
