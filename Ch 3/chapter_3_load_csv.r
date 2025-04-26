# Step 1: Load necessary packages
print("Loading packages...")
pacman::p_load(readr, dplyr) # readr for read_csv, dplyr for glimpse
print("Packages ready.")

# Step 2: Load the CSV file using read_csv()
# Again, use the relative path from the project root.
print("Loading tabular data country_indicators.csv...")

country_indicators_loaded <- readr::read_csv("country_indicators.csv")

# Step 3: Inspect the loaded data
print("CSV data loaded successfully!")
print("--- Object Class ---")
print(class(country_indicators_loaded)) # Should be 'spec_tbl_df', 'tbl_df', 'tbl', 'data.frame'
print("--- First few rows ---")
print(head(country_indicators_loaded))
print("--- Column Summary (glimpse) ---")
dplyr::glimpse(country_indicators_loaded) # Useful for seeing column types

# Make the object available outside the chunk if needed
assign("country_indicators_loaded",
       country_indicators_loaded,
       envir = .GlobalEnv)