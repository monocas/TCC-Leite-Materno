#!/bin/bash
#SBATCH -n 1
#SBATCH --ntasks-per-node=80
#SBATCH -p gpu
#SBATCH --gres=gpu:t4:1
#SBATCH --time=12:00:00

source ~/.bashrc

# Ativar ambiente conda
conda activate bioinfo

#Diretório
diretorio="/home/public/Leite-Materno/2.Trimmomatics/*"
echo $diretorio

#Variavel para encontrar o caminho do bowtie
bowtie2=/home/monyque220063/estagio/software/bowtie2/bowtie2-2.5.3-sra-linux-x86_64/bowtie2
echo $bowtie2

for i in $diretorio/*_1P.fq
do
        BASE=$(basename $i _1_1P.fq)

        $bowtie2 -1 $diretorio/${BASE}_1_1P.fq -2 $diretorio/${BASE}_2_2P.fq -x GRCh38_genoma_humano/GRCh38_noalt_as -p 80 -S ${BASE}_bowtie.sam

done
