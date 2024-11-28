#!/bin/bash
#SBATCH -n 3
#SBATCH --ntasks-per-node=30
#SBATCH -p batch-AMD
#SBATCH --time=120:00:00

source /home/barbara.rodrigues/anaconda3/bin/activate
#source ~/.bashrc
conda activate gtdbtk-2.1.1
#conda activate mpa

caminho_genomas=/home/public/Leite-Materno/7.Genomas_Filtrados
echo $caminho_genomas

caminho_taxonomia=/home/public/Leite-Materno/8.gtdbtk
echo $caminho_taxonomia

for i in ${caminho_genomas}/*_genomas
do
    SAMPLE=$(basename $i _genomas)
    gtdbtk classify_wf --genome_dir ${caminho_genomas}/${SAMPLE}_genomas/ -x fa --out_dir ${caminho_taxonomia}/${SAMPLE}_taxonomia
done

