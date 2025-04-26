# --- Script: chapter_5_setup.R ---

# Step 1: Load necessary packages
print("Loading packages...")
# Ensure pacman is installed and loaded if you use it
if (!requireNamespace("pacman", quietly = TRUE)) 
  install.packages("pacman")
pacman::p_load(
  sf, tidyverse, rnaturalearth, maps, ggrepel
)
# maps package has simpler world.cities data
# ggrepel for non-overlapping labels later
print("Packages ready.")

# Step 2: Get world boundaries for background map
print("Getting world boundaries...")
world_map_background <- rnaturalearth::ne_countries(
  scale = 'medium', returnclass = 'sf') |>
  dplyr::select(iso_a2, name, geometry) # Keep only a few columns
print("World boundaries loaded.")

# Step 3: Get world city data 
# (using maps::world.cities for simplicity)
# This data is simpler and smaller than rnaturalearth cities for 
# this example
print("Loading city data from 'maps' package...")
cities_df <- maps::world.cities |>
  # Optional: Filter for larger cities if desired
  dplyr::filter(pop > 1000000) |>
  dplyr::select(name, country.etc, pop, lat, long)

# CRUCIAL: Convert the data frame to an sf object!
# Need to specify coordinate columns and the CRS 
# (WGS84 for this dataset)
cities_sf <- sf::st_as_sf(
  cities_df,
  coords = c("long", "lat"), # IMPORTANT: Longitude first!
  crs = 4326) # Assume WGS84 Lat/Lon
print("City data loaded and converted to sf object:")
print(head(cities_sf))
print(paste("Number of cities loaded:", nrow(cities_sf)))

# Store for later use
assign(
  "world_map_background", world_map_background, 
  envir = .GlobalEnv)
assign("cities_sf", cities_sf, envir = .GlobalEnv)