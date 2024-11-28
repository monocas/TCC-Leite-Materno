#!/bin/bash
#SBATCH -n 3
#SBATCH --ntasks-per-node=3
#SBATCH -p gpu
#SBATCH --gres=gpu:t4:1
#SBATCH --time=96:00:00

source /home/barbara.rodrigues/anaconda3/bin/activate
conda activate bioinfo
#source ~/.bashrc

samtools=/home/barbara.rodrigues/estagio/softwares/samtool/samtools-1.9/./samtools
echo $samtools

#Variavel para encontrar o caminho do bowtie2
bowtie2=/home/barbara.rodrigues/estagio/softwares/bowtie2/bowtie2-2.5.3-sra-linux-x86_64/bowtie2
echo $bowtie2

#Variavel para encontrar outro caminho do bowtie2
bowtie2_build=/home/barbara.rodrigues/estagio/softwares/bowtie2/bowtie2-2.5.3-sra-linux-x86_64/bowtie2-build
echo $bowtie2_build

#Variavem para encontrar caminho dos aquivos fastq
caminho_fastq=/home/public/Leite-Materno/1.data_input/1.milk_cutadapter
echo $caminho_fastq

caminho_data=/home/public/Leite-Materno/4.megahit/final_contigs_milk_cutadapter

for i in $caminho_data/*.fa
do
    
    BASE=$(basename "$i" _finalcontigs.fa)

   awk 'NR%4==1{a=$0} NR%4==2{b=$0} NR%4==3{c=$0} NR%4==0&&length(b)>1000{print a"\n"b"\n"c"\n"$0;}' $caminho_data/${BASE}_finalcontigs.fa  > 1.milk_filtered_cutadapter/${BASE}_finalcontigs_filter.fa

    # FUB - PRESTAR ATENÇAO USAR O FILETER PARA OUTRAS OCASIÕES 
    
    $bowtie2_build /home/public/Leite-Materno/5.metabat2/1.milk_filtered_cutadapter/${BASE}_finalcontigs_filter.fa /home/public/Leite-Materno/5.metabat2/1.milk_filtered_cutadapter/${BASE}_banco

    #$bowtie2_build /home/public/Leite-Materno/4.megahit/final_contigs_milk/${BASE}_finalcontigs.fa /home/public/Leite-Materno/5.metabat2/1.milk_filtered/${BASE}_banco

    $bowtie2 -x 1.milk_filtered_cutadapter/${BASE}_banco -1 $caminho_fastq/${BASE}_1.fastq -2 $caminho_fastq/${BASE}_2.fastq -S 1.milk_filtered_cutadapter/${BASE}.sam -p 60

    $samtools view -S -b 1.milk_filtered_cutadapter/${BASE}.sam > 1.milk_filtered_cutadapter/${BASE}.bam

    $samtools sort 1.milk_filtered_cutadapter/${BASE}.bam -o 1.milk_filtered_cutadapter/${BASE}_sorted.bam -@ 60

    $samtools index 1.milk_filtered_cutadapter/${BASE}_sorted.bam

    jgi_summarize_bam_contig_depths --outputDepth 1.milk_filtered_cutadapter/${BASE}_depth.txt --referenceFasta 1.milk_filtered_cutadapter/${BASE}_finalcontigs_filter.fa 1.milk_filtered_cutadapter/${BASE}_sorted.bam

    metabat2 -i 1.milk_filtered_cutadapter/${BASE}_finalcontigs_filter.fa -a 1.milk_filtered_cutadapter/${BASE}_depth.txt -o 1.milk_bins_cutadapter/${BASE}_bins -t 60

done
