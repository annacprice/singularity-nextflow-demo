process bacterialAssembly_shovill {
    /**
    * Bacterial assembly from paired fastq using shovill (https://github.com/tseemann/shovill)
    * @input tuple dataset_id, path(forward), path(reverse)
    * @output shovill_out tuple dataset_id, path("${dataset_id}.fasta")
    * @operator none
    */
 
    tag { dataset_id }
 
    publishDir "${params.outputDir}/${task.process.replaceAll(":", "_")}", pattern: "${dataset_id}.fasta", mode: 'copy'   

    errorStrategy 'ignore' 

    cpus 4

    memory '8 GB'

    input:
    tuple val(dataset_id), path(forward), path(reverse)

    output:
    tuple val(dataset_id), path("${dataset_id}.fasta"), emit: shovill_out optional true
   
    script:
    """
    shovill --cpus ${task.cpus} --R1 ${forward} --R2 ${reverse} --minlen 500 --outdir shovill
    mv shovill/contigs.fa ${dataset_id}.fasta
    """
}
