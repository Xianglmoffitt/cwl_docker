#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: CommandLineTool

hints:
  DockerRequirement:
    dockerPull: broadinstitute/gatk

baseCommand: ["gatk", "SplitNCigarReads"]

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
 
  Outbam:
    type: string
    inputBinding:
      prefix: "-O"

  CreateIndex:
    type: boolean?
    inputBinding:
      prefix: --create-output-bam-index

outputs:
  Out_bam:
    type: File
    outputBinding:
      glob: $(inputs.Outbam)
    secondaryFiles:
      - ^.bai
