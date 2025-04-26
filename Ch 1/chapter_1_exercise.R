# Quick CRS Introduction Exercise

# Step 1: Ensure sf is loaded
pacman::p_load(sf, rnaturalearth) # Need rnaturalearth for the data

# Step 2: Get world map data as an sf object
print("Getting world map data...")
world_sf <- rnaturalearth::ne_countries(scale = 'medium', returnclass = 'sf')
print("World data loaded.")

# Step 3: Check the CRS of this data!
print("Checking the original CRS...")
original_crs <- st_crs(world_sf)
print(original_crs)
# Look for the EPSG code near the bottom! Should be 4326 (WGS84 Lat/Lon)

# Step 4: Define a different target CRS (e.g., Robinson Projection)
# Robinson is often used for world maps. We use its "ESRI" code here.
target_crs_robinson <- "ESRI:54030"
print(paste("Target CRS:", target_crs_robinson))

# Step 5: Transform the data to the new CRS using st_transform()
print("Transforming data to Robinson projection...")
# The |> pipe sends world_sf to the st_transform function
world_robinson_sf <- world_sf |>
  st_transform(crs = target_crs_robinson)
print("Transformation complete!")

# Step 6: Check the CRS of the NEW, transformed data
print("Checking the NEW CRS...")
new_crs <- st_crs(world_robinson_sf)
print(new_crs)
# Notice the name and details are different now! It's no longer EPSG:4326.

# Step 7: Quick plot comparison (using base plot for simplicity here)
print("Plotting comparison (Original vs. Transformed)...")
par(mfrow = c(2, 1)) # Arrange plots side-by-side
plot(
  sf::st_geometry(world_sf), 
  main = "Original (EPSG:4326)", 
  key.pos = NULL, reset = FALSE, 
  border="grey30", cex.main = 5,
  lwd = 3
  )
plot(
  sf::st_geometry(world_robinson_sf), 
  main = "Transformed (Robinson)", 
  key.pos = NULL, reset = FALSE, border="blue", 
  cex.main = 5, lwd = 3
)
par(mfrow = c(1, 1)) # Reset plot layout
print("Plots displayed. Notice the shape difference!")
