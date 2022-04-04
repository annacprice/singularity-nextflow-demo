// trimAssemble sub-workflow

// enable dsl2
nextflow.enable.dsl = 2

// import modules
include {qualityControl_trimgalore} from '../modules/qualityControl' params(params)
include {bacterialAssembly_shovill} from '../modules/bacterialAssembly.nf' params(params)

// trimAssemble workflow
workflow trimAssemble {
  
  take:

    inputReads

  main:

    qualityControl_trimgalore(inputReads)

    bacterialAssembly_shovill(qualityControl_trimgalore.out.trimgalore_out)

}
