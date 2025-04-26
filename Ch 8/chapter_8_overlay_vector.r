# --- Script: chapter_8_overlay_vector.R ---
# (Can be in same script)

# Step 1: Ensure needed data exists from previous steps
pacman::p_load(
  terra, tidyverse, tidyterra, ggnewscale, geodata
)

print("Fetching Swiss boundary...")

ch_boundary_sf <- geodata::gadm(
  country = "CHE", level = 0, path = tempdir()) |>
  sf::st_as_sf() |>
  sf::st_transform(
    crs = terra::crs(swiss_elev_raster)) # Match raster CRS

assign("ch_boundary_sf", ch_boundary_sf, envir = .GlobalEnv)

# Step 2: Add the shaded relief map from the previous step
# and then add the boundary layer

shaded_relief_with_border <- shaded_relief_map +
  # ADD LAYER: Country Boundary using geom_sf - TOP
  geom_sf(
    data = ch_boundary_sf,
    fill = NA,
    color = "black",
    linewidth = 0.5
  ) + # NA fill, black border
  # Labels and theme
  labs(
    title = "Shaded Relief Map of Switzerland with Border",
    x = "Longitude",
    y = "Latitude",
    caption = paste("Data: SRTM 30s via geodata.", "Hillshade: Sun from West (270 deg)")
  ) +
  coord_sf(crs = terra::crs(swiss_elev_raster)) + # Use
  # appropriate CRS
  theme_minimal() +
  theme(legend.position = "right", axis.text = element_blank())

# Step 3: Display map
print(shaded_relief_with_border)
print("Map with boundary overlay generated.")