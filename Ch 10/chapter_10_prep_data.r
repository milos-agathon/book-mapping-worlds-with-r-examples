# --- Script: chapter_10_prep_data.R ---
# (Can be in same script)

# Step 1: Get Swiss elevation data (as SpatRaster)
# Reload if needed, or use object from Chapter 8 if still in
# environment

country_iso <- "CHE"

swiss_elev_raster <- geodata::elevation_30s(
  country = country_iso, path = tempdir())
print("Elevation data loaded.")

assign(
  "swiss_elev_raster", swiss_elev_raster, 
  envir = .GlobalEnv
)

print("Using existing 'swiss_elev_raster' object.")

# Step 2: Convert the SpatRaster to a matrix using
# rayshader::raster_to_matrix
# This function specifically prepares the raster data for rayshader
# functions.
print("Converting elevation raster to matrix...")
elevation_matrix <- rayshader::raster_to_matrix(
  swiss_elev_raster)
print("Conversion complete!")

# Step 3: Inspect the matrix (optional, to see the structure)
print("--- Matrix Dimensions (rows, columns) ---")
print(dim(elevation_matrix))
print("--- Top-Left Corner Values (elevation numbers) ---")
# Show the elevation numbers for the first 5 rows and 5 columns
print(elevation_matrix[1:5, 1:5])

# Store matrix for later use
assign("elevation_matrix", elevation_matrix, envir = .GlobalEnv)