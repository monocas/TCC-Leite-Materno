#!/bin/bash
#SBATCH -n 1
#SBATCH --ntasks-per-node=15
#SBATCH -p batch-AMD
#SBATCH --time=96:00:00


source ~/.bashrc
#conda activate metaphlan
conda activate metaphlan


caminho_data=/home/public/Leite-Materno/3.samtools/1.milk_cutadapter/colostrum
echo $caminho_data


for i in $caminho_data/*_1.fastq
do

    SAMPLE=$(basename "$i" _1.fastq)

    if [ -f "$caminho_data/${SAMPLE}_2.fastq" ]; then
        echo "$SAMPLE"
        metaphlan "${caminho_data}/${SAMPLE}_1.fastq,${caminho_data}/${SAMPLE}_2.fastq" \
       	--input_type fastq \
	--bowtie2out "/home/public/Leite-Materno/9.metaphlan/bowtie2_colostrum/${SAMPLE}_bowtie2.bz2" \
	-o /home/public/Leite-Materno/9.metaphlan/bowtie2_colostrum/Metaphlan_${SAMPLE}_colostrum.txt \
	--nproc 15
    else
        echo "Aviso: ${caminho_data}/${SAMPLE}_2.fastq não encontrado. Pulando ${caminho_data}/${SAMPLE}."
    fi

done
