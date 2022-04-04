# singularity-nextflow-demo
Singularity and Nextflow DSL2 Demo

## Singularity
Singularity is a container engine. Containers are used to deploy software in a lightweight, standalone, and reproducible environment. By isolating software in a container, it ensures that software will run uniformly regardless of platform.

See the following sections in the wiki for the Singularity demo:
1) [Getting started with Singularity](https://github.com/annacprice/singularity-nextflow-demo/wiki/Getting-started-with-Singularity)
2) [How to assemble a genome using a Singularity container](https://github.com/annacprice/singularity-nextflow-demo/wiki/How-to-assemble-a-genome-using-a-Singularity-container)

## Nextflow

### How to run the workflow
The workflow is designed to run with either docker `-profile docker` or singularity `-profile singularity`. E.g. to run
```
nextflow run main.nf -profile [docker, singularity]
```

### About the workflow
This workflow runs the read trimming tool [`trim_galore`](https://github.com/FelixKrueger/TrimGalore) followed by the bacterial assembler [`Shovill`](https://github.com/tseemann/shovill)

It is written in Nextflow DSL2. Nextflow is a workflow manager that can be used to create scalable data-intensive bioinformatics workflows from existing software and scripts. DSL2 is a new syntax, which allows the creation of more modular workflows. In DSL2, the main workflow calls sub-workflows which are built from processes (a software analysis is defined in a process). The sub-workflows and processes are reusable.

The software dependencies of the workflow are managed using containers. Each process in the workflow has an associated container image which is pulled from quay.io.

The combination of Nextflow DSL2 and containers allows for the building of scalable and reproducible workflows.


### Walkthrough of the files
* `main.nf`</br>
Here the input channel for the paired reads is declared and the main workflow which calls the sub-workflow trimAssemble is defined.
* `workflows/trimAssemble.nf`</br>
The sub-workflow trimAssemble is defined which calls the processes for trim_galore and Shovill from the module files.
* `modules/qualityControl.nf` and `modules/bacterialAssembly.nf` </br>
Processes are stored in module files. Here a library-based approach is used where processes are divided into module files by their function.
* `nextflow.config` </br>
The config contains the parameters for the workflow and profiles for docker and singularity.
