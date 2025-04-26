# --- Script: chapter_7_crop_raster.R ---
# (Can be in same script)

# Step 1: Load necessary packages
pacman::p_load(terra, sf, rnaturalearth) # rnaturalearth helps get continent boundaries

# Step 2: Ensure global elevation raster exists
# Step 3: Get South America boundary polygon using rnaturalearth
print("Fetching South America boundary...")
sa_boundary_sf <- rnaturalearth::ne_countries(
  scale = 'medium',
  continent = "South America",
  returnclass = 'sf') |>
  dplyr::select(iso_a3 = adm0_a3, name, geometry)
  
print("Boundary fetched.")

# Step 4: CRITICAL - Check CRS match between raster and
# vector polygon
# Mismatched CRS is a very common error source when
# cropping!
print("--- Checking CRS ---")
# Use terra::crs() for raster, st_crs() for sf object
# Get comparable proj strings or EPSG codes if possible
raster_crs_str <- terra::crs(global_elevation_10min, proj = TRUE)
vector_crs_sf <- sf::st_crs(sa_boundary_sf) # Get sf crs
# object

print(paste(
  "Raster CRS:",
  terra::crs(global_elevation_10min, describe = TRUE)$name
))
print(paste("Vector CRS:", vector_crs_sf$Name))

# Step 5: Transform if necessary
# (they should both be WGS84 here)
# Compare EPSG codes if available and reliable

# Transform the vector boundary to match the raster's CRS
sa_boundary_sf <- sa_boundary_sf |>
  sf::st_transform(crs = terra::crs(global_elevation_10min))
print("Vector CRS transformed.")

# Step 6: Crop the raster using the sf polygon boundary
print("Cropping global elevation raster to South America")
# terra::crop(raster_to_crop, object_to_crop_with)
# mask=TRUE makes pixels outside polygon NA (good for
# non-rectangular shapes)
sa_elevation <- terra::crop(global_elevation_10min, sa_boundary_sf, mask =
                              TRUE)
print("Cropping complete.")

# Step 7: Inspect the cropped raster (check the new,
# smaller extent!)
print("--- Cropped Raster Summary ---")
print(sa_elevation)
print("--- End Summary ---")

# Step 8: Plot the cropped raster using terra::plot for
# quick view
print("Plotting cropped raster...")
terra::plot(sa_elevation)
print("Cropped plot displayed.")

# Store for potential use
assign("sa_elevation", sa_elevation, envir = .GlobalEnv)
