

![Bioinformática e Maternidade (1)](https://github.com/user-attachments/assets/faca3d80-24ec-4d41-85aa-c41c85975528)


![LICENSE](https://img.shields.io/badge/LICENSE-GNU%20General%20Public%20License%20v3.0-red) 

<h1 align="center"> ANÁLISE DOS FATORES DE VIRULÊNCIA ADVINDOS DE CLUSTERS GÊNICOS BIOSSINTÉTICOS DA MICROBIOTA DO LEITE HUMANO E SUA INFLUÊNCIA NA SAÚDE MATERNA E NEONATAL 🤱👶 </h1>

O objetivo geral deste projeto foi identificar, em escala genômica e via análises in silico, os fatores de virulência presentes em BGCs existentes na microbiota do leite humano e no intestino de recém-nascidos, compreendendo como este conjunto de fatores é correlacionado com os ambientes socioeconômicos em que as mulheres estão inseridas.
## Bem-vindo!😊

Este repositório de GitHub é dedicado ao trabalho de conclusão de curso do Bacharelado em Ciência e Tecnologia da Ilum Escola de Ciência, faculdade parte do Centro Nacional de Pesquisa em Energia e Materiais (CNPEM). Tendo como responsáveis as alunas:




- [Barbara da Paixão Perez Rodrigues](https://github.com/barbaraperez)
- [Monyque Karoline de Paula Silva](https://github.com/monocas)
- [Paola Ferrari](https://github.com/palolaferrari)
- [Sarah Peixoto Rodrigues Freire](https://github.com/Sarah-Freire) (colaboradora)
- [Eduarda Veiga Carvalho](https://github.com/veigaeduarda) (colaboradora)

Esse estudo permitiu com que o leite humano fosse estudado a partir de diferentes óticas: biológica, antropológica, computacional e social, correlacionando todas elas para ter resultados condizentes com a realidade de cada mulher. Além disso, o projeto contribuiu para a formação profissional e pessoal das alunas que conceberam a ideia e a executaram, permitindo troca de saberes entre pesquisadores, alunos e profissionais na área da saúde e indústria, essenciais para pleno desenvolvimento do trabalho.
 Desse modo, abaixo temos uma explicação do trabalho.

![image](https://github.com/user-attachments/assets/d9436792-0e52-49b6-8579-a902cbd9e27e)

## Principais arquivos 🔍

<p align="justify"> Guia para navegar nesse Git; </p>

Desse modo, as seguintes pastas compõem esse repositório:
- [0.Data_Input](https://github.com/monocas/TCC-Leite-Materno/tree/main/0.Data_Input): Dados utilizados no projeto.
- [1.1.FastQC](https://github.com/monocas/TCC-Leite-Materno/tree/main/1.1.FastQC): Arquivo gerado pelo software FASTQC que realiza o controle de qualidade inicial das sequências.
- [1.2.MultiQC](https://github.com/monocas/TCC-Leite-Materno/tree/main/1.2.MultiQC): Resultado gerado pelo software MultiQC que escaneia os resultados dos relatórios de controle de qualidade do FastQC.
- [2.Trimmomatics](https://github.com/monocas/TCC-Leite-Materno/tree/main/2.Trimmomatics): Remoção de adaptadores moleculares e bases com baixa qualidade de sequenciamento.
- [3.Bowtie](https://github.com/monocas/TCC-Leite-Materno/tree/main/3.Bowtie): Execução da etapa final do pré-processamento dos dados metagenômicos, responsável pela remoção de informações genéticas correspondentes ao hospedeiro da amostra, permitindo a análise dos genomas restantes, bacterianos.
- [4.Samtools](https://github.com/monocas/TCC-Leite-Materno/tree/main/4.Samtools): Conversão de arquivos do formato SAM (Sequence Alignment Map) para FASTQ.
- [5.MegaHit](https://github.com/monocas/TCC-Leite-Materno/tree/main/5.MegaHit): Formação dos contigs.
- [6.MetaBat2](https://github.com/monocas/TCC-Leite-Materno/tree/main/6.MetaBat2): Montagem dos genomas juntando contigs em bins.
- [7.Checkm](https://github.com/monocas/TCC-Leite-Materno/tree/main/7.Checkm): Avaliação da qualidade da reconstrução do genoma.
- [8.GTDBTK](https://github.com/monocas/TCC-Leite-Materno/tree/main/8.GTDBTK): Genome Taxonomy Database Toolkit. Identificação dos genomas bacterianos presentes. 
- [9.Metaphlan](https://github.com/monocas/TCC-Leite-Materno/tree/main/9.Metaphlan): Identificação taxonômica apartir de dados de sequenciamento bruto, shotgun, filtrados apenas utilizando as ferramentas de pré-processamento.
- [Antismash/bgc_analise](https://github.com/monocas/TCC-Leite-Materno/tree/main/Antismash/bgc_analise): Identificação de Clusters Gênicos Biossintéticos (BGCs).
- [PathoFact](https://github.com/monocas/TCC-Leite-Materno/tree/main/PathoFact): Predição dos fatores de virulência.
- [Tamanho_contigs](https://github.com/monocas/TCC-Leite-Materno/tree/main/Tamanho_contigs): Avaliação estatística do tamanho de contigs, arquivo de saída do MegaHit.
- [_NextFlow](https://github.com/monocas/TCC-Leite-Materno/tree/main/_NextFlow): Ferramenta utilizada para a criação de um pipeline para automatização de workflow.
- [LICENSE](https://github.com/monocas/TCC-Leite-Materno/blob/main/LICENSE): Contém a licença a que este trabalho está submetida.
- [README.md](https://github.com/monocas/TCC-Leite-Materno/blob/main/README.md): Presente arquivo, introdução e guia de nevegação do repositório.




