#!/bin/bash
#SBATCH --job-name=trimm
#SBATCH -n 1
#SBATCH --ntasks-per-node=40
#SBATCH -p batch-AMD
#SBATCH --time=96:00:00
 
source ~/.bashrc

# Ativar o ambiente conda com trimmomatics 
conda activate trimmomatics
 
# Criar o diretório
mkdir -p phred_20
 
# Comando Paired End para leitura das reads em dois sentidos
# Retirada do adapatador ILLUMINACIP
# Seleção da qualidade da base SLIDINGWINDOW 
# Corte de sequências menores de 50 MINLEN
 
for i in *.fastq
do
        BASE=$(basename $i _1.fastq)
 
        trimmomatic PE -threads 40 -phred33  ${BASE}_1.fastq ${BASE}_2.fastq phred_20/${BASE}_1_1P.fq phred_20/${BASE}_1_1U.fq phred_20/${BASE}_2_2P.fq phred_20/${BASE}_2_2U.fq ILLUMINACLIP:/home/monyque220063/estagio/adapters/NexteraPE-PE.fa:2:30:10 SLIDINGWINDOW:5:20 MINLEN:50
done
