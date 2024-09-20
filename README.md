# KEGG-Othology-parser
Working with genome annotations, at some point you will probably face a long list of KO numbers, and you may want the entire KEGG hirarchy on your annotations (for multiple downstream analysis). The first thing you may think is "Ok, if I have a table with all the hierachical KEGG orthology, I would be able to merge my annotations with this table". But the real world is never so easy, and simple tables compiling hierarchichal information are not so easy to come by. This script helps to parse one the formats available in KEGG to parse the entire orthology into a simple tabular form. 

To simplify the code, no paralellization has been included, so the script takes a couple of minutes to run a full KEGG orthology. It creates a a table with the following columns
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
