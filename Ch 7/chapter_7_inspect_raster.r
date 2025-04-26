# --- Script: chapter_7_inspect_raster.R ---
# (Can be in same script)

# Ensure the raster object exists before inspecting
print("Inspecting raster properties...")

# Step 1: Check Resolution (Pixel Size X, Y)
# terra::res() returns the size of one pixel in map units
# (degrees here).
print("--- Resolution (x, y degrees) ---")
print(terra::res(global_elevation_10min))
# Expected output: Shows approx 0.1667 x 0.1667 degrees

# Step 2: Check Extent (Bounding Box)
# terra::ext() shows the geographic boundaries (edges) of the
# raster.
print("--- Extent (xmin, xmax, ymin, ymax) ---")
print(terra::ext(global_elevation_10min))
# Expected output: Shows ext(-180, 180, -90, 90) for global data

# Step 3: Check Coordinate Reference System (CRS)
# terra::crs() gives details about the map projection and datum.
print("--- CRS (WKT format) ---")
print(terra::crs(global_elevation_10min))
# Expected output: Shows detailed WGS 84 definition (EPSG:4326)

# Step 4: Check Number of Layers/Bands
# terra::nlyr() tells us how many bands the raster has.
print("--- Number of layers ---")
print(terra::nlyr(global_elevation_10min))
# Expected output: 1 (since it's just elevation)

# Step 5: Look at some Pixel Values (use head() for large
# rasters!)
# terra::values() extracts the actual data values from the
# pixels.
# CAUTION: This can be huge for large rasters! Use head() to
# see just the start.
print("--- First 6 pixel values ---")
# Convert to vector first for head() to work cleanly
print(head(terra::values(global_elevation_10min)[, 1]))
# Expected output: Shows the actual elevation numbers for the
# first 6 pixels

# Step 6: Get Min/Max Values efficiently
# terra::minmax() quickly finds the minimum and maximum pixel
# values.
print("--- Min/Max values ---")
print(terra::minmax(global_elevation_10min))
# Expected output: Shows the lowest and highest elevation found
# globally