# --- Script: chapter_3_saving.R ---

# Step 1: Load required package
message("Loading packages...")
pacman::p_load(sf)

# Step 2: Define output path
output_filename <- "world_data_cleaned_joined.gpkg"
message("Saving cleaned data to: ", output_filename)

# Step 4: Write the GeoPackage
sf::st_write(world_data_joined, output_filename, delete_layer = TRUE)

message("Data saved successfully!")