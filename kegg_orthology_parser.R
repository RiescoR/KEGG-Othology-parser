#This script takes the htext (ko0001.kegg) and parses it into a readable tsv file. It outputs a file called KEGG_Orthology_complete.tsv into the folder where the input file is.

#Download the htext file from https://www.genome.jp/kegg-bin/get_htext?ko00001



##VARIABLES TO DEFINE
# Define the input file path (must be a htext file (.kegg) downloaded from KEGG, see first line of the script)
input_file_path <- "C:/Users/raul/Desktop/Antrihabitans_trees_ANI_AAI/Genomes/KEGG/kegg_orthology/ko00001.keg"


#=====================DO NOT CHANGE ANYTHING FROM HERE===========================================
  
library(data.table)

# Extract the directory path from the input file path
output_directory <- dirname(input_file_path)

# Define the output file path
output_file_path <- file.path(output_directory, "KEGG_Orthology_complete.tsv")

# Read the file
lines <- readLines(input_file_path)

# Variables (3 classes)
current_class1 <- NULL
current_class2 <- NULL
current_class3 <- NULL

# Helper function to remove codes in class 1, 2 and 3 
remove_code <- function(class_str) {
  sub("^\\S+\\s+(.*)$", "\\1", class_str)
}

# Function to extract path/brite code and type (PATHWAY//BRITE) in class3
extract_path_brite <- function(class_str) {
  if (grepl("\\[PATH:ko\\d+\\]$", class_str)) {
    code <- sub(".*\\[PATH:(ko\\d+)\\]$", "\\1", class_str)
    type <- "PATHWAY"
  } else if (grepl("\\[BR:ko\\d+\\]$", class_str)) {
    code <- sub(".*\\[BR:(ko\\d+)\\]$", "\\1", class_str)
    type <- "BRITE"
  } else {
    code <- NA
    type <- NA
  }
  return(list(code = code, type = type))
}

# Function to extract parts of class4 (this function is nuts >_<)
extract_class4_parts <- function(class_str) {
  ko_code <- sub("^(\\S+).*", "\\1", class_str)
  abbreviated_name <- sub("^\\S+\\s+([^;]+);.*", "\\1", class_str)
 
  
  # Extract EC numbers including the "EC:" prefix
  ec_numbers <- ifelse(grepl(".*(\\[EC:[^\\]]*)", class_str), sub(".*(\\[EC:[^\\]]*)", "\\1", class_str), NA)
  ec_numbers <- gsub("\\[EC:|\\]", "", ec_numbers)
  ec_numbers <- gsub(" ", ";", ec_numbers)


  complete_name <- sub("^\\S+\\s+[^;]+;\\s+(.*?)(\\s*\\[EC:.*\\])?$", "\\1", class_str)
  complete_name <- ifelse(is.na(ec_numbers), sub("^\\S+\\s+[^;]+;\\s+(.*)", "\\1", class_str), complete_name)
  complete_name <- trimws(complete_name)
  
  return(list(ko_code = ko_code, abbreviated_name = abbreviated_name, complete_name = complete_name, ec_numbers = ec_numbers))
}

# Create a data.table to store the results (an empty one)
results <- data.table(
  Class1 = character(),
  Class2 = character(),
  Class3 = character(),
  PathBrite_code = character(),
  PATH_or_BRITE = character(),
  KO_code = character(),
  Abbreviated_gene_name = character(),
  Complete_gene_name = character(),
  EC_number = character()
)

# Parse the lines and fill the data.table (It takes the first letter to categorize the line, then uses the previous fountion to subset the interesting parts, and eliminate pointless codes)
for (line in lines) {
  if (grepl("^A", line)) {
    # Level 1 hierarchy (A)
    current_class1 <- remove_code(sub("^A\\s+\\s(.*)$", "\\1", line))
  } else if (grepl("^B", line)) {
    # Level 2 hierarchy (B)
    current_class2 <- remove_code(sub("^B\\s+\\s(.*)$", "\\1", line))
  } else if (grepl("^C", line)) {
    # Level 3 hierarchy (C)
    class3_full <- sub("^C\\s+\\s(.*)$", "\\1", line)
    path_brite_info <- extract_path_brite(class3_full)
    current_class3 <- remove_code(sub("\\s*\\[.*\\]$", "", class3_full))
    path_brite_code <- path_brite_info$code
    path_brite_type <- path_brite_info$type
  } else if (grepl("^D", line)) {
    # Level 4 hierarchy (D)
    class4_full <- sub("^D\\s+\\s(.*)$", "\\1", line)
    class4_parts <- extract_class4_parts(class4_full)
    results <- rbindlist(list(results, data.table(
      Class1 = current_class1, 
      Class2 = current_class2, 
      Class3 = current_class3, 
      PathBrite_code = path_brite_code, 
      PATH_or_BRITE = path_brite_type, 
      KO_code = class4_parts$ko_code, 
      Abbreviated_gene_name = class4_parts$abbreviated_name, 
      Complete_gene_name = class4_parts$complete_name, 
      EC_number = class4_parts$ec_numbers
    )), use.names = TRUE, fill = TRUE)
  }
}

#Exporting the table (into a tsv)
fwrite(results, file = output_file_path, sep = "\t")
