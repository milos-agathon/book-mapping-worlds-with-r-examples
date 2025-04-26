# Step 1: Load necessary packages

print("Loading packages...")
# Ensure pacman is installed and loaded if you use it
if (!requireNamespace("pacman", quietly = TRUE))
  install.packages("pacman")
pacman::p_load(sf, dplyr) # Need sf for st_read,
# dplyr for glimpse later
print("Packages ready.")

# Step 2: Load the GeoPackage file using st_read()
# We provide the RELATIVE PATH from the project root folder.
# Our file is inside the 'data' subfolder.
print("Loading vector data world_boundaries.gpkg...")

world_boundaries_loaded <- sf::st_read("world_boundaries.gpkg")

# Step 3: Inspect the loaded data
print("Inspecting the data...")
print(class(world_boundaries_loaded))

print("First few rows:")
print(head(world_boundaries_loaded))

print("Coordinate Reference System:")
print(sf::st_crs(world_boundaries_loaded))

# Make the object available outside the chunk if needed
assign("world_boundaries_loaded", world_boundaries_loaded, envir = .GlobalEnv)