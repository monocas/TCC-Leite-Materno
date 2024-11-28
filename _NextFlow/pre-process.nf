params.fastq = "/home/monyque220063/nextflow/fastq/*.fastq"
params.qc_report = "/home/monyque220063/nextflow/fastq_report"
params.multiqc_report = "/home/monyque220063/nextflow/multiqc_report"
params.adapters_dir = "/home/monyque220063/nextflow/adapters"
params.adapter_file = "NexteraPE-PE.fa"
params.trimmed_output = "/home/monyque220063/nextflow/trimmed_fastq"
params.cutadapt_output = "/home/monyque220063/nextflow/cutadapt_output"
params.fastqc_final_output = "/home/monyque220063/nextflow/fastqc_final"  // Nova pasta de saída para FastQC final
params.multiqc_final_output = "/home/monyque220063/nextflow/multiqc_final"  // Nova pasta de saída para MultiQC final

// Parâmetros ajustáveis do Trimmomatic
params.adapter_options = "2:30:10"
params.sliding_window = "5:10"
params.minlen = 50

// Processo de QC
process QC {
    publishDir("${params.qc_report}", mode: 'copy')

    input:
    path fastq

    output:
    path "*"

    script:
    """
    fastqc $fastq
    """
}

// Processo de MultiQC
process MultiQC {
    publishDir("${params.multiqc_report}", mode: 'copy')

    input:
    path qc_files

    output:
    path "multiqc_report.html"

    script:
    """
    multiqc $qc_files -o .
    """
}

// Processo de Trimming
process Trimming {
    publishDir "${params.trimmed_output}", mode: 'copy'

    input:
    path fastq1
    path fastq2
    path adapter_file

    output:
    path "trimmed_${fastq1.getName()}"
    path "trimmed_${fastq2.getName()}"
    path "unpaired_${fastq1.getName()}"
    path "unpaired_${fastq2.getName()}"

    script:
    """
    trimmomatic PE -phred33 $fastq1 $fastq2 \
        trimmed_${fastq1.getName()} unpaired_${fastq1.getName()} \
        trimmed_${fastq2.getName()} unpaired_${fastq2.getName()} \
        ILLUMINACLIP:$adapter_file:${params.adapter_options} \
        SLIDINGWINDOW:${params.sliding_window} MINLEN:${params.minlen}
    """
}

// Processo de Cutadapt
process Cutadapt {
    publishDir("${params.cutadapt_output}", mode: 'copy')

    input:
    path trimmed_read

    output:
    path "polyA_removed_${trimmed_read.getName()}"

    script:
    """
    cutadapt -a AAAAAAAAAA -o polyA_removed_${trimmed_read.getName()} $trimmed_read
    """
}

// Processo de FastQC final
process FastQC_Final {
    publishDir("${params.fastqc_final_output}", mode: 'copy')  // Nova pasta de saída para FastQC final

    input:
    path cutadapt_output

    output:
    path "*"

    script:
    """
    fastqc $cutadapt_output
    """
}

process MultiQC_Final {
    publishDir("${params.multiqc_final_output}", mode: 'copy')

    input:
    path cutadapt_qc_files

    output:
    path "multiqc_final_report.html"

    script:
    """
    multiqc $cutadapt_qc_files -o . --filename multiqc_final_report.html
    """
}

workflow {
    // Canal de entrada para os arquivos fastq
    fastq_ch = Channel.fromPath(params.fastq)
    adapter_ch = Channel.fromPath("${params.adapters_dir}/${params.adapter_file}")

    // Separar os pares de leitura
    fastq1_ch = fastq_ch.filter { it.name.endsWith("_1.fastq") }
    fastq2_ch = fastq_ch.filter { it.name.endsWith("_2.fastq") }

    // QC inicial e MultiQC inicial
    qc_results = QC(fastq_ch)
    multiqc_result = MultiQC(qc_results)

    // Trimming dos arquivos fastq
    trimming_results = Trimming(fastq1_ch, fastq2_ch, adapter_ch)

    // Selecionar todos os arquivos que começam com "trimmed_" no diretório de saída
    trimmed_ch = Channel.fromPath("${params.trimmed_output}/trimmed_*")

    // Processamento com Cutadapt para todos os arquivos "trimmed_*"
    cutadapt_results = Cutadapt(trimmed_ch)

    // Processo de FastQC final após Cutadapt
    fastqc_final_results = FastQC_Final(cutadapt_results)

    // Processo de MultiQC final - Aguardando todos os FastQC_final
    multiqc_final_result = MultiQC_Final(fastqc_final_results)
}
