#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

hints:
  DockerRequirement:
    dockerPull: broadinstitute/gatk

baseCommand: ["gatk", "HaplotypeCaller"]

inputs:
  # REQUIRED ARGS

  Reference:
    type: File
    inputBinding:
      prefix: "-R"
    secondaryFiles:
      - .fai
      - ^.dict

  Inbam: 
    type: File
    inputBinding:
      prefix: "-I"
    secondaryFiles:
      - ^.bai
 
  out_name:
    type: string
    inputBinding:
      prefix: "-O"

outputs:
  vcf:
    type: File
    outputBinding:
      glob: "*.vcf"
