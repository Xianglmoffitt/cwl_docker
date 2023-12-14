#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

hints:
  DockerRequirement:
    dockerPull: broadinstitute/gatk

baseCommand: ["gatk", "MarkDuplicates"]

inputs:
  # REQUIRED ARGS

  InputFile:
    type: File
    inputBinding:
      prefix: "--INPUT"

  Output: 
    type: string
#    default: "markdup.bam"
    inputBinding:
      prefix: "--OUTPUT" 
 #     valueFrom: "markdup.bam"

  MetricsFile: 
    type: string
  #  default: "markdup_metrics.txt"
    inputBinding:
      prefix: "--METRICS_FILE" 
   #   valueFrom: "markdup_metrics.txt"

  # OPTIONAL ARGS

  isCreateIndex:
    type: boolean?
    inputBinding:
      prefix: "--CREATE_INDEX"


outputs:
  alignment:
    type: File
    outputBinding:
      glob: "*.bam"
    secondaryFiles:
      - ^.bai
  metrics:
    type: File
    outputBinding:
      glob: "*.txt"
