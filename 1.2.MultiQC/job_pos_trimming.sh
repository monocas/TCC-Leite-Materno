#!/bin/bash
#SBATCH --job-name=fastqc
#SBATCH -n 1
#SBATCH --ntasks-per-node=20
#SBATCH -p batch-AMD
#SBATCH --time=96:00:00

source ~/.bashrc

# Ambiente virtual com MultiQC presente
conda activate multiqc 

# Criar o diretório
mkdir -p resultados

# Caminho dos dados
caminho_data="../1.FastQC/resultados_pos_trimming"

# Loop para pegar todos os dados .fastq
for i in *.fastq
do
        # Todos os resultados serão alocados no diretorio resultado
        multiqc $i -t 20 -o resultados_report_pos_trimming
done
