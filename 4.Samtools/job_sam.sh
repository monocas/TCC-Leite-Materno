#!/bin/bash
#SBATCH -n 1
#SBATCH --ntasks-per-node=12
#SBATCH -p batch-AMD
#SBATCH --time=12:00:00

source /home/barbara.rodrigues/anaconda3/bin/activate

# Ativar o ambiente conda
conda activate bioinfo

# Caminho para o funcionamento da ferramenta
samtools=/home/barbara.rodrigues/estagio/softwares/samtool/samtools-1.9/./samtools

# Caminho para os dados de entrada
diretorio=/home/public/Leite-Materno/2.bowtie/*

# Definir as variaveis 
echo $diretorio
echo $samtools


for i in $diretorio/*.sam
do
        BASE=$(basename $i _bowtie.sam)

        $samtools view -bS $diretorio/${BASE}_bowtie.sam > 2.gut/${BASE}_bowtie.bam

        $samtools view -b -f 12 -F 256 2.gut/${BASE}_bowtie.bam > 2.gut/${BASE}_bowtie_2.bam

        $samtools sort -n -m 5G -@ 2 2.gut/${BASE}_bowtie_2.bam -o 2.gut/${BASE}_sorted.bam
        $samtools fastq -@ 8 2.gut/${BASE}_sorted.bam -1 2.gut/${BASE}_sample_host_removed_1.fastq.gz -2 2.gut/${BASE}_sample_host_removed_2.fastq.gz
done
