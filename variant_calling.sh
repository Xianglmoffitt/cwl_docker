#!/bin/bash

export PROJECT_DIR="/Users/4472271/Projects/all_scripts/CWL_workflow"
export DATA_DIR="$PROJECT_DIR/data"
export REF_DIR="$PROJECT_DIR/hpv16_ref"

cd $PROJECT_DIR

touch $DATA_DIR/output.metrics


java -jar ~/tools/picard.jar MarkDuplicates I=$DATA_DIR/hpv16_input.bam O="$DATA_DIR/markdup.bam" CREATE_INDEX=true M=$DATA_DIR/metrics

~/tools/gatk-4.5.0.0/gatk SplitNCigarReads -R $REF_DIR/HPV16_K02718.1.fa -I $DATA_DIR/markdup.bam -O $DATA_DIR/splitntrim.bam

~/tools/gatk-4.5.0.0/gatk HaplotypeCaller -R $REF_DIR/HPV16_K02718.1.fa -I $DATA_DIR/splitntrim.bam -O hpv.vcf
