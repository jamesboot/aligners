# This script collates bismark methylation results for multiple samples

# Read in command line args 
args <- commandArgs(trailingOnly = TRUE)

# Specify arguements from command line args 
analysisDir <- args[1]
covFileSuffix <- args[2]
outFileName <- args[3]

# Report inputs
message(paste('Analysis Dir:', analysisDir))
message(paste('Coverage File Suffix:', covFileSuffix))
message(paste('Out File:', outFileName))

# Set working directory
message('Setting working directory...')
setwd(analysisDir)

# Required packages:
message('Loading packages...')
packages <- c('tidyverse')

# Install any packages not already
install.packages(setdiff(packages, rownames(installed.packages())))

# Load packages
lapply(packages, library, character.only = T)

# Locate cov files at path
message('Locating files...')
files <- list.files(path = getwd(),
                    pattern = '*.cov.gz',
                    full.names = T,
                    recursive = T)

# Log
message('Files found:')
files

# Create sample names from file paths
message('Creating sample names...')
localFiles <- basename(files)
samples <- gsub(covFileSuffix, '', localFiles)
message('Samples found:')
samples

# Read in files
message('Loading files...')
results <- lapply(files, function(x) {
  read.delim(
    file = gzfile(x),
    sep = '\t',
    header = F,
    col.names = c(
      'chromosome',
      'start',
      'end',
      'percent.meth',
      'n.meth.Cs',
      'n.unmeth.Cs'
    )
  )
})

# Print example of dataframe loaded
message('1st element of loaded list of dataframes:')
results[[1]]

# Rename list elements by sample
names(results) <- samples

# Change row names of list elements
for (x in 1:length(results)) {
  
  # Get sample name
  sampName <- names(results)[x]
  
  # Create location col
  results[[x]]$location <- paste0(results[[x]]$chromosome,
                                '-',
                                results[[x]]$start,
                                '-',
                                results[[x]]$end)
  
  # Subset to relevant cols
  results[[x]] <- results[[x]][, c('location',
                               'percent.meth',
                               'n.meth.Cs',
                               'n.unmeth.Cs')]
  
  # Add sample name to colnames
  amendCols <- paste0(sampName, '.', colnames(results[[x]])[2:4])
  newCols <- c('location', amendCols)
  colnames(results[[x]]) <- newCols
  
}


# Print example of dataframe modified
message('1st element of modified list of dataframes:')
results[[1]]

# Create vector of suffixes for merging
suffixes <- paste0('.', samples)

# Message suffixes
message('Suffixes:')
suffixes

# Merge list elements by location
merged <- reduce(.x = results, full_join, by = "location")

# Write output to csv file
write.csv(merged, file = outFileName)




