#!/usr/bin/env nextflow

import groovy.io.FileType



nextflow.enable.dsl = 2

// Define the pipeline input parameters
params.reads = "$baseDir/*_{1,2}.fastq.gz"

// Create output directory for trimmed reads
params.trimmedDir = "$baseDir/trimmed"
if (!file(params.trimmedDir).exists()) {
    file(params.trimmedDir).mkdirs()
}

// Create directory for assembly output
params.assemblyDir = "$baseDir/assembly"
if (!file(params.assemblyDir).exists()) {
    file(params.assemblyDir).mkdirs()
}

// Describe workflow using created processes
workflow {
    // Create a channel emitting the given file pairs
    reads = Channel.fromFilePairs(params.reads, checkIfExists: true)

    // Step one: trim reads
    trimmed = bbduk(reads)

    // Step two: assembly
    skesa(trimmed)
}

// Use bbduk to trim reads
process bbduk {
    // Set a tag
    tag "Trim ${sampleID}"

    // Publish output to trimmed reads directory
    publishDir params.trimmedDir, mode:'copy'

    input:
    tuple val(sampleID), path(reads) 

    output:
    tuple val(sampleID), path("${sampleID}_trimmed_{1,2}.fastq.gz")

    script:
    """
    bbduk.sh \\
        in=${reads[0]} \\
        in2=${reads[1]} \\
        out=${sampleID}_trimmed_1.fastq.gz \\
        out2=${sampleID}_trimmed_2.fastq.gz \\
        k=31 \\
        hdist=1 \\
        t=4 \\
        qtrim=r \\
        trimq=20 \\
        minlen=36
    """
}

// Assemble trimmed output using skesa
process skesa {
    // Set a tag
    tag "Assemble $sampleID"

    // Publish output to assembly directory
    publishDir params.assemblyDir, mode:'copy'

    input:
    tuple val(sampleID), path(trimmedReads) 
    
    output:
    path "${sampleID}.fna"

    script:
    """
    skesa --memory 5 --reads ${trimmedReads[0]} ${trimmedReads[1]} --contigs_out ${sampleID}.fna
    """
}

