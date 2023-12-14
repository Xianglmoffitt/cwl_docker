cwlVersion: v1.2
class: Workflow

inputs:
  - id: genome
    type: File 
    secondaryFiles:
      - .fai
      - ^.dict

  - id: in_bam
    type: File
  - id: markdup_bam
    type: string
  - id: metrics_out
    type: string
  - id: isCreateIndex_1
    type:  boolean
  - id: splitNcigar_bam
    type: string
  - id: CreateIndex_2
    type: boolean
  - id: out_vcf
    type: string
  
steps:
  markduplicates:
    run: ./gatk-MarkDuplicates.cwl
    in:
      InputFile: in_bam
      MetricsFile: metrics_out
      Output: markdup_bam
      isCreateIndex: isCreateIndex_1
    out: [alignment, metrics]

  splitNcigar:
    run: ./gatk-SplitNCigarReads.cwl
    in:
      Reference: genome
      Inbam: markduplicates/alignment
      Outbam: splitNcigar_bam
      CreateIndex: CreateIndex_2
    out: [Out_bam]

  haplotypecaller:
    run: ./gatk-HaplotypeCaller.cwl
    in:
      Reference: genome
      Inbam: splitNcigar/Out_bam
      out_name: out_vcf
    out: [vcf]

outputs:
  markdup_bam_out:
    type: File
    outputSource: markduplicates/alignment
  mark_metric:
    type: File
    outputSource: markduplicates/metrics
  vcf_file:
    type: File
    outputSource: haplotypecaller/vcf

