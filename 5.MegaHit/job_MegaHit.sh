#!/bin/bash
#SBATCH -n 1
#SBATCH --ntasks-per-node=80
#SBATCH -p batch-AMD
#SBATCH --time=96:00:00

# Ativar o ambiente conda
source ~/.bashrc
conda activate megahit

# Input da entrada

diretorio=/home/public/Leite-Materno/3.samtools/*

for i in $diretorio/*_1.fastq
do
    SAMPLE=$(basename "$i" _1.fastq)

    if [ -f "$diretorio/${SAMPLE}_2.fastq" ]; then
        echo "$SAMPLE"
        megahit -1 "$diretorio/${SAMPLE}_1.fastq" -2 "$diretorio/${SAMPLE}_2.fastq" -o "1.milk_cutadapter/${SAMPLE}_megahit" -m 0.5
    else
        echo "Aviso: $diretorio/${SAMPLE}_2.fastq não encontrado. Pulando $diretorio/$SAMPLE."
    fi
done
