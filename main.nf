#!/usr/bin/env nextflow

// enable dsl2
nextflow.enable.dsl = 2

// import subworkflows
include {trimAssemble} from './workflows/trimAssemble.nf'

// define workflow
workflow {

  // input run directory
  runDir = "${params.inputDir}"

  // input reads 
  allFastq = "${runDir}/*_{1,2}.fastq.gz"

  // create channel from paired reads
  Channel.fromFilePairs( "${allFastq}", flat: true )
         .set{ inputReads }

  // main workflow
  main:

    // call the sub-workflow trimAssemble 
    trimAssemble(inputReads)

}
