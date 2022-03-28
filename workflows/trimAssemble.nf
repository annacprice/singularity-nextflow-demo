// trimAssemble sub-workflow

// enable dsl2
nextflow.preview.dsl = 2

// import modules
include {qualityControl_trimgalore} from '../modules/qualityControl' params(params)
include {bacterialAssembly_shovill} from '../modules/bacterialAssembly.nf' params(params)

// workflow component for trimAssemble
workflow trimAssemble {
  
  take:

    inputReads

  main:

    qualityControl_trimgalore(inputReads)

    bacterialAssembly_shovill(qualityControl_trimgalore.out.trimgalore_out)

}
