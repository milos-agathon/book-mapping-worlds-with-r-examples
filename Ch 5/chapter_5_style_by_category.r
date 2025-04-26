# --- Script: chapter_5_style_by_category.R ---
# (Can be in same script)

# Step 1: Ensure packages and data exist
pacman::p_load(sf, tidyverse, rnaturalearth)
# We need country polygons with continent info
# Reload background map to ensure 'continent'
# column is present
world_polygons_cont <- rnaturalearth::ne_countries(scale = 'medium', returnclass = 'sf') |>
  dplyr::select(name, continent, geometry) |> # Keep only needed cols
  sf::st_make_valid()  # ← fix any self-crossing or invalid rings

# (Optional) If you still see S2 errors, disable S2:
# sf::sf_use_s2(FALSE)

# Use st_join with st_within: find which polygon each city
# point is WITHIN. Make sure both layers use the same CRS
# (they should both be 4326 here)

cities_sf <- sf::st_transform(cities_sf, sf::st_crs(world_polygons_cont))

# Perform the join, keeping city attributes by default
cities_with_continent <- sf::st_join(cities_sf, world_polygons_cont, join = sf::st_within)
print("Spatial join complete.")
# Check the result - should have a 'continent' column now
print(head(cities_with_continent[, c("name.x", "continent")]))
# Store the joined data
assign("cities_with_continent", cities_with_continent, envir = .GlobalEnv)


# Step 3: Create map, coloring points by continent
print("Creating map colored by continent...")

map_color_by_cont <- ggplot() +
  # Background map
  geom_sf(
    data = world_map_background,
    fill = "grey90",
    color = "white",
    linewidth = 0.1
  ) +
  
  # City points - MAP continent to COLOR!
  geom_sf(
    data = cities_with_continent |>
      dplyr::filter(!is.na(continent)),
    # Filter out points not
    # joined
    # Use aes() to map 'continent' column to 'color'
    aes(color = continent),
    size = 1.5,
    # Fixed size
    shape = 16,
    # Fixed shape
    alpha = 0.7
  ) + # Fixed transparency
  
  # Step 4: Customize the color scale for categorical data
  # Use scale_color_brewer for qualitative palettes
  # (good for categories)
  # Or scale_color_viridis_d for discrete viridis colors
  scale_color_brewer(palette = "Set1", name = "Continent") +
  
  # Add title and theme
  labs(title = "World Cities Colored by Continent") +
  theme_minimal() +
  theme(axis.text = element_blank(), legend.position = "bottom") +
  guides(color = guide_legend(override.aes = list(size = 3))) # Make legend points larger

# Step 5: Display the map
print("Displaying map...")
print(map_color_by_cont)