#!/usr/bin/env bash
#SBATCH -J braker
#SBATCH --partition=himem
#SBATCH --mem-per-cpu=4G
#SBATCH --cpus-per-task=24


WorkDir=$TMPDIR/${SLURM_JOB_USER}_${SLURM_JOBID}
Assembly=$1
OutDir=$2
AcceptedHits=$3
GeneModelName=$4
CurDir=$PWD

echo "$Assembly"
echo "$OutDir"
echo "$AcceptedHits"
echo "$GeneModelName"
echo "$CurDir"

mkdir -p $WorkDir
cd $WorkDir

cp $CurDir/$Assembly assembly.fa
cp $CurDir/$AcceptedHits alignedRNA.bam



braker.pl \
  --GENEMARK_PATH=/home/gomeza/prog/genemark/gmes_linux_64 \
  --overwrite \
  --fungus \
  --gff3 \
  --softmasking on \
  --species=$GeneModelName \
  --genome="assembly.fa" \
  --bam="alignedRNA.bam"

mkdir -p $CurDir/$OutDir
cp -r braker/* $CurDir/$OutDir/.

rm -r $WorkDir