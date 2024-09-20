# KEGG-Othology-parser
When working with genome annotations, you'll likely encounter a long list of KO numbers. In such cases, you might want to include the entire KEGG hierarchy in your annotations for various downstream analyses. Your first thought might be, "If I had a table with the complete hierarchical KEGG orthology, I could simply merge my annotations with it." However, reality and imagination do not always meet face to face. You will find it's not that straightforward to compile hierarchical information formats into simple and readable tables. This script helps parse one of the available KEGG formats, converting the entire orthology into a simple tabular form, preserving the hierachical information in a readable form.

The script creates a a table with the following columns
  * Class1: First KEGG supercategory (Metabolism, Genetic Information Processing, Environmental Information Processing, etc.)
  * Class2: Second KEGG supercategory (Carbohydrate metabolism, Energy metabolism, etc)
  * Class3: Third KEGG supergategory, equivalent to pathway for KO codes
  * PathBrite_code
  * PATH_or_BRITE: it defines if the annotation is a Pathway or part of brite
  * KO_code
  * Abreviated_gene_name: If multiple, separated with a ", "
  * Complete_gene_name
  * EC_number: If multiple, separated with a ";"

The output is a file called KEGG_Orthology_complete.tsv that will be placed into the folder where the input file is.

## To parse the entire KEGG orthology to a tab file
  1) Download the htext file from https://www.genome.jp/kegg-bin/get_htext?ko00001
  2) Define the input_file_path variable in the R script (must be a path pointing to a htext file (.kegg) downloaded from KEGG, see first line of the script)

     Example:
     `input_file_path <- "C:/Users/user/Desktop/Antrihabitans_trees_ANI_AAI/Genomes/KEGG/kegg_orthology/ko00001.keg"`
     
  4) Run the script. A tsv table called "KEGG_Orthology_complete.tsv" should habe been created in the same path as the htext file. 

I’ve included two test files in the repository: a simplified KEGG orthology file (ko00001_test.keg), which is essentially a subset of the entire database, and the full hierarchy downloaded in April 2024 (ko00001.keg). Feel free to test the script using these input files.


## Variables to define in the script
Define the input_file_path (must be a htext file (.kegg) downloaded from KEGG, see first line of the script)

## Dependencies
 * R (with or without R studio, tested for version 4.2.2)
 * data.table (tested for version 1.15.4)

## Contact info
The script is quite straigthforward to run, but if you face any problems or you need help to adapt the script to your needs, please contact me via email (raul.riescoj@usal.es)
