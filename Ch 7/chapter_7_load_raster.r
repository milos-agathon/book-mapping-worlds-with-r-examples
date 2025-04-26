# --- Script: chapter_7_load_raster.R ---
# (Can be in same script)

# Step 1: Use geodata to download and load global elevation data
# res = 10 means 10 arc-minute resolution (coarse, smaller file)
# path = tempdir() saves the download temporarily
print("Fetching 10-minute resolution global elevation data
  using geodata...")
# This might take a moment the first time it downloads the file!

global_elevation_10min <- geodata::elevation_global(
  res = 10, path = tempdir())
print("Elevation data downloaded/loaded!")

# Step 2: Print the object to see the summary
# This shows the key properties of the raster data we loaded.
print("--- Raster Summary ---")
print(global_elevation_10min)
print("--- End Summary ---")

# Store for later use
assign(
  "global_elevation_10min", 
  global_elevation_10min, envir = .GlobalEnv)