#!/bin/bash
#SBATCH --job-name=fastqc
#SBATCH -n 1
#SBATCH --ntasks-per-node=20
#SBATCH -p batch-AMD
#SBATCH --time=96:00:00

source ~/.bashrc

# Ambiente virtual com FASTQ presente
conda activate fastq 

# Criar o diretório
mkdir -p resultados

# Caminho dos dados
caminho_data="../2.Cutadapt"

# Loop para pegar todos os dados .fastq
for i in *.fastq
do
        # Todos os resultados serão alocados no diretorio resultado
        fastqc $i -t 20 -o resultados_pos_trimming
done
