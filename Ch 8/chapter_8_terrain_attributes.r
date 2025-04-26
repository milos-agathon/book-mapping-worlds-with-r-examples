# --- Script: chapter_8_terrain_attributes.R ---
# (Can be in same script)

# Step 1: Calculate Slope and Aspect using terra::terrain()
print("Calculating slope and aspect...")
# Input is the elevation raster
# v = c("slope", "aspect") specifies which attributes to
# calculate
# unit="radians" gives slope in radians
terrain_attributes <- terra::terrain(
  swiss_elev_raster,
  v = c("slope", "aspect"),
  unit = "radians")
print("Slope and aspect calculated.")

# Inspect the result - it's a SpatRaster with MULTIPLE layers!
print("--- Terrain Attributes Summary ---")
print(terrain_attributes)
# Note it now has two layers named 'slope' and 'aspect'

# Step 2: Plot Slope and Aspect individually using terra::plot()
print("Plotting slope...")
# Select the 'slope' layer using $slope or [[1]]
# col = viridis(100) uses 100 colors from the viridis palette
terra::plot(
  terrain_attributes$slope,
  main = "Slope (Radians)",
  col = viridis(100))

print("Plotting aspect...")
# Select the 'aspect' layer using $aspect or [[2]]
# Aspect is circular so rainbow() is sometimes
# used but hcl.colors("Circular") is often better.
terra::plot(
  terrain_attributes$aspect,
  main = "Aspect (Radians from North)",
  col = viridis(100))

# Step 3: Calculate Hillshade using terra::shade()
print("Calculating hillshade...")
# Requires the slope and aspect layers (which we just
# calculated)
# angle = 45 sets the sun's altitude (45 Radians above horizon)
# direction = 270 sets the sun's direction (270=West, 0=N,
# 90=E, 180=S)
# We pass the slope and aspect layers directly from our
# multi-layer object
hillshade <- terra::shade(
  terrain_attributes[[1]],
  terrain_attributes[[2]],
  angle = 45,
  direction = 270)
print("Hillshade calculated.")

# Inspect the hillshade raster (single layer, values 0-255)
print("--- Hillshade Summary ---")
print(hillshade)

# Step 4: Plot the Hillshade (greyscale is standard)
print("Plotting hillshade...")
# Use a grey color palette: grey(0:100/100) creates 101 shades
# of grey
# legend = FALSE turns off the unnecessary color legend for
# hillshade
terra::plot(
  hillshade,
  col = grey(0:100 / 100),
  legend = FALSE,
  main = "Hillshade (Sun from West)"
)
print("Hillshade plot done.")

# Store for later use
assign(
  "hillshade", hillshade, envir = .GlobalEnv
)
assign(
  "terrain_attributes", 
  terrain_attributes, envir = .GlobalEnv
)