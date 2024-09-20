# KEGG-Othology-parser
When working with genome annotations, you'll likely encounter a long list of KO numbers. In such cases, you might want to include the entire KEGG hierarchy in your annotations for various downstream analyses. Your first thought might be, "If I had a table with the complete hierarchical KEGG orthology, I could simply merge my annotations with it." However, reality and imagination do not always meet face to face. You will find it's not that straightforward to compile hierarchical information formats into simple and readable tables. This script helps parse one of the available KEGG formats, converting the entire orthology into a simple tabular form, preserving the hierachical information in a readable form.

### Output Structure
The script generates a table with the following columns:

  * **Class1**: First KEGG supercategory (e.g., Metabolism, Genetic Information Processing, Environmental Information Processing)
  * **Class2**: Second KEGG category (e.g., Carbohydrate metabolism, Energy metabolism)
  * **Class3**: Third KEGG category, typically representing pathways for KO codes
  * **PathBrite_code**
  * **PATH_or_BRITE**: Indicates whether the annotation is a pathway or part of BRITE
  * **KO_code**
  * **Abbreviated_gene_name**: Multiple entries separated by a comma and a space (", ")
  * **Complete_gene_name**
  * **EC_number**: Multiple entries separated by a semicolon (";")

The output file is named **KEGG_Orthology_complete.tsv** and will be saved in the same folder as the input file.

---

## How to Parse the Entire KEGG Orthology to a Tab File

1. Download the htext file from [KEGG](https://www.genome.jp/kegg-bin/get_htext?ko00001).
2. Set the `input_file_path` variable in the R script to point to the downloaded htext file (.keg). 

    Example:
    ```R
    input_file_path <- "C:/Users/user/Desktop/Antrihabitans_trees_ANI_AAI/Genomes/KEGG/kegg_orthology/ko00001.keg"
    ```

3. Run the script. A TSV table named **KEGG_Orthology_complete.tsv** will be created in the same directory as the htext file.

I’ve included two test files in the repository: a simplified KEGG orthology file (*ko00001_test.keg*), which is a subset of the full database, and the complete hierarchy downloaded in April 2024 (*ko00001.keg*). Feel free to test the script using these files.

---

## Variables to Define in the Script

- **input_file_path**: This should point to an htext file (.keg) downloaded from KEGG (see the first line of the script).

---

## Dependencies

- **R** (tested with version 4.2.2, works with or without RStudio)
- **data.table** (tested with version 1.15.4)

---

## Contact Information

The script is straightforward to run, but if you encounter any issues or need help adapting the script to your specific needs, feel free to contact me via email: [raul.riescoj@usal.es](mailto:raul.riescoj@usal.es).
