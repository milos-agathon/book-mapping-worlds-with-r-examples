# --- Script: chapter_2_explore_sf.R ---

# Step 1: Load necessary packages
# We need sf for spatial operations, rnaturalearth for data,
# and tidyverse for data viewing/manipulation.
print("Loading packages...")
pacman::p_load(sf, rnaturalearth, tidyverse)
print("Packages ready")

# Step 2: Get world countries data as an sf object
# This is vector data (polygons)
print("Getting world countries sf object...")
world_countries <- rnaturalearth::ne_countries(
  scale = 'medium', returnclass = 'sf')
print("Data loaded into 'world_countries'.")

# Step 3: Get world cities data as an sf object
# This is vector data (points)
print("Getting world cities sf object...")
world_cities <- rnaturalearth::ne_download(
  scale       = "medium",
  type        = "populated_places",   # <— note this
  category    = "cultural",           # defaults to "cultural"
  returnclass = "sf"
)
print("Data loaded into 'world_cities'.")

# Inspecting the world_countries sf object

# Step 4: Print the whole object - see the table + geometry
print("--- Full sf object (first few rows) ---")
print(world_countries)
# Notice it looks like a table, but the last column is 'geometry'
# and it shows the geometry type (MULTIPOLYGON) and CRS info!

# Step 5: Check the class - What kind of object is it?
print("--- Object Class ---")
print(class(world_countries))
# Expected output: Should include "sf" and "data.frame" - it's both!

# Step 6: Use glimpse() for a compact summary of attributes
print("--- Attribute Summary (glimpse) ---")
# glimpse() is from dplyr, great for seeing column names and types
dplyr::glimpse(world_countries)
# Look at all the attribute columns (like name, continent, pop_est) 
# and their types (<chr>, <dbl>)
# Find the special 'geometry' column at the end (<MULTIPOLYGON [°]>)

# Step 7: Look at JUST the attribute table (like a regular data 
# frame)
print("--- Attribute Table Only (st_drop_geometry) ---")
# sf::st_drop_geometry() removes the special geometry column
world_attributes_only <- sf::st_drop_geometry(world_countries)
print(head(world_attributes_only)) # Show first few rows of the 
# plain table
print(class(world_attributes_only)) # Should now just be "data.
# frame"

# Step 8: Look at JUST the geometry column
print("--- Geometry Column Only (st_geometry) ---")
# sf::st_geometry() extracts only the geometry list-column
world_geometry_only <- sf::st_geometry(world_countries)
print(world_geometry_only[1:3]) # Show geometry info for the first 
# 3 countries
print(class(world_geometry_only)) # Should be "sfc" (simple feature 
# column) and "sfc_MULTIPOLYGON"

# Step 9: Check the CRS again!
print("--- Coordinate Reference System (st_crs) ---")
print(sf::st_crs(world_countries))
# Confirm it's likely EPSG:4326 (WGS84 Lat/Lon)

# CRS Transformation Recap

# Step 10: Transform world_countries to Robinson projection again
print("Transforming countries to Robinson...")
target_crs_robinson <- "ESRI:54030" # Robinson code
world_countries_robinson <- world_countries |>
  sf::st_transform(crs = target_crs_robinson)
print("Transformation complete.")

# Step 11: Check the NEW CRS
print("--- CRS of Transformed Data ---")
print(sf::st_crs(world_countries_robinson))

# Step 12: Plot comparison (using ggplot this time!)
print("Plotting comparison with ggplot2...")

plot_original <- ggplot() + 
  geom_sf(
    data = world_countries, linewidth=0.2
  ) + ggtitle("Original (EPSG:4326)") + 
  theme_minimal()
plot_transformed <- ggplot() + 
  geom_sf(
    data = world_countries_robinson, linewidth=0.2
  ) + 
  ggtitle("Transformed (Robinson)") + 
  theme_minimal()

# Arrange side-by-side (requires 'patchwork' package)
pacman::p_load(patchwork)
print(plot_original / plot_transformed)
print("Comparison plot displayed.")