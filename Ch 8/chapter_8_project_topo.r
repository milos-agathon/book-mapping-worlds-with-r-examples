# --- Script: chapter_8_project_topo.R ---
# Step 1: Choose Region & Setup
print("Loading packages for Topo Map Exercise...")
pacman::p_load(
  terra, geodata, sf, tidyverse, 
  tidyterra, ggnewscale)
theme_set(theme_minimal())

# --- USER INPUT: SET YOUR COUNTRY ISO CODE & NAME HERE ---
# Example: "PER" for Peru, "NZL" for New Zealand, "ITA" for Italy
your_iso_code <- "PER"
your_country_name <- "Peru"
# ----------------------------------------------------------

# Step 2: Get Data

paste(
  "Fetching elevation data for",
  your_country_name, "(may take time)...")

elevation_raster <- geodata::elevation_30s(
  country = your_iso_code, path = tempdir())
names(elevation_raster) <- "elevation" # Rename layer
print("Elevation data loaded.")

print(paste("Fetching boundary for", your_country_name))

boundary_sf <- geodata::gadm(
  country = your_iso_code,
  level = 0,
  path = tempdir()) |>
  sf::st_as_sf() |>
  sf::st_transform(
    crs = terra::crs(elevation_raster)) # Match CRS

# Step 3: Calculate Terrain Attributes
print("Calculating terrain attributes...")
terrain_attrs <- terra::terrain(
  elevation_raster,
  v = c("slope", "aspect"),
  unit = "degrees")

hillshade_raster <- terra::shade(
  terrain_attrs[[1]],
  terrain_attrs[[2]],
  angle = 45,
  direction = 225) # Sun from NE
names(hillshade_raster) <- "hillshade_val"
print("Terrain attributes calculated.")

# Step 4: Prepare for ggplot
print("Converting rasters to data frame...")
elev_df <- terra::as.data.frame(
  elevation_raster, xy = TRUE, na.rm = TRUE)

hill_df <- terra::as.data.frame(
  hillshade_raster, xy = TRUE, na.rm = TRUE)
print("Data prepared for ggplot.")

# Step 5: Set the limits
limits <- terra::minmax(elevation_raster)

# Step 6: Create Shaded Relief Map
print("Creating shaded relief map...")
topo_map_project <- ggplot() +
  # Hillshade layer
  geom_raster(
    data = hill_df,
    aes(
      x = x, y = y, 
      fill = hillshade_val
    ), 
    show.legend = FALSE) +
  scale_fill_gradientn(
    colors = hcl.colors(
      12, "Light Grays", rev = TRUE), # A light gray palette
    na.value = NA # Transparent for any missing cells
  ) +
  # Elevation layer
  ggnewscale::new_scale_fill() +
  geom_raster(
    data = elev_df,
    aes(x = x, y = y, fill = elevation)) +
  tidyterra::scale_fill_hypso_tint_c(
    palette = "dem_poster",
    limits = limits,
    alpha = 0.5) +
  # Optional boundary
      geom_sf(
        data = boundary_sf,
        fill = NA,
        color = "black",
        linewidth = 0.3
      ) +
  # Labels, coord, theme
  labs(
    title = paste(
      "Shaded Relief Map of", your_country_name),
       caption = "Data: SRTM 30s via geodata") +
  coord_sf(
    crs = terra::crs(elevation_raster), expand = FALSE) +
  theme_void() +
  theme(
    legend.position = "right",
    plot.title = element_text(hjust = 0.5, face = "bold"))

# Step 6: Print
print(topo_map_project)
print("Map created.")

# Step 7: Bonus Save
# ggsave(
# paste0(your_iso_code, "_topo_map.png"),
# plot = topo_map_project, width = 7, height = 8,
# dpi = 300, bg = "white")
# print("Map potentially saved.")

# Cleanup
# rm(elev_df, hill_df, terrain_df)
# gc()