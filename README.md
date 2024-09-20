# KEGG-Othology-parser
Small R script to parse htext file (.keg) to a tab separated table. To simplify the code, no paralellization has been included, so the script takes a couple of minutes to run a full KEGG orthology. It creates a a table with the following columns
  * Class1: First KEGG supercategory (Metabolism, Genetic Information Processing, Environmental Information Processing, etc.)
  * Class2: Second KEGG supercategory (Carbohydrate metabolism, Energy metabolism, etc)
  * Class3: Third KEGG supergategory, equivalent to pathway for KO codes
  * PathBrite_code
  * PATH_or_BRITE: it defines if the annotation is a Pathway or part of brite
  * KO_code
  * Abreviated_gene_name: If multiple, separated with a ", "
  * Complete_gene_name
  * EC_number: If multiple, separated with a ";"

This script takes the htext (ko0001.kegg) and parses it into a readable tsv file. It outputs a file called KEGG_Orthology_complete.tsv into the folder where the input file is.

## To parse the entire KEGG orthology to a tab file
  1) Download the htext file from https://www.genome.jp/kegg-bin/get_htext?ko00001
  2) Define the input_file_path variable in the R script (must be a path pointing to a htext file (.kegg) downloaded from KEGG, see first line of the script)

     Example:
     `input_file_path <- "C:/Users/user/Desktop/Antrihabitans_trees_ANI_AAI/Genomes/KEGG/kegg_orthology/ko00001.keg"`
     
  4) Run the script. A tsv table called "KEGG_Orthology_complete.tsv" should habe been created in the same path as the htext file. 



## Variables to define in the script
Define the input_file_path (must be a htext file (.kegg) downloaded from KEGG, see first line of the script)

## Dependencies
 * R (with or without R studio, tested for version 4.2.2)
 * data.table (tested for version 1.15.4)
