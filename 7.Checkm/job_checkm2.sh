#!/bin/bash
#SBATCH -n 1
#SBATCH --ntasks-per-node=1
#SBATCH -p gpu
#SBATCH --gres=gpu:t4:1
#SBATCH --time=96:00:00

source ~/.bashrc
conda activate checkm2

checkm2 predict --threads 60 --input /home/public/Leite-Materno/5.metabat2/2.gut_bins --output-directory Checkm2 -x fa
