# Feature Barcode Count

Cell Ranger processes all Feature Barcode data through a counting pipeline that quantifies each feature in each cell. This analysis is done by the cellranger count pipeline. The pipeline outputs a unified feature-barcode matrix that contains gene expression counts alongside Feature Barcode counts for each cell barcode. The feature-barcode matrix replaces the gene-barcode matrix emitted by older versions of Cell Ranger.

#### For more information see 10X website: 
https://support.10xgenomics.com/single-cell-gene-expression/software/pipelines/latest/using/feature-bc-analysis

#### Running analysis:
1. Script named cellranger_feat_bc.sh is needed
2. Two CSV files:
3. Libraries CSV (example_libraries.csv)
4. Feature Reference CSV (example_feat_ref.csv)
