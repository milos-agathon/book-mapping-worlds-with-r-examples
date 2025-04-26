# --- Script: chapter_8_shaded_relief.R ---
# (Can be in same script)

# Step 1: Ensure ggplot2, terra, dplyr, tidyterra and 
# ggnewscale are loaded
pacman::p_load(terra, tidyverse, tidyterra, ggnewscale)
print("Converting rasters to data frames for ggplot2...")

# Rename layers for clarity BEFORE converting
names(swiss_elev_raster) <- "elevation"
names(hillshade) <- "hillshade_val"

# Use as.data.frame with xy=TRUE to get coordinates
# Use na.rm=TRUE to potentially reduce data frame size
elev_df_gg <- terra::as.data.frame(
  swiss_elev_raster, xy = TRUE, na.rm = TRUE)

hillshade_df_gg <- terra::as.data.frame(
  hillshade, xy = TRUE, na.rm = TRUE)

# Step 2: Create the ggplot map with hillshade overlay
print("Creating shaded relief map...")

limits <- terra::minmax(swiss_elev_raster)

shaded_relief_map <- ggplot() +
  geom_raster(
    data = hillshade_df_gg,
    aes(x = x, y = y, fill = hillshade_val),
    show.legend = FALSE
  ) +
  # Choose a light gray palette for the hillshade layer.
  # scale_fill_gradientn() lets us define exactly how 
  # numeric values map to colors.
  scale_fill_gradientn(
    colors = hcl.colors(
      12, "Light Grays", rev = TRUE), # A light gray palette
    na.value = NA # Transparent for any missing cells
  ) +
  ggnewscale::new_scale_fill() +
  # Second layer: draw the elevation raster on top of the hillshade.
  geom_raster(
    data = elev_df_gg,
    aes(x = x, y = y, fill = elevation),
    alpha = 0.5 # decrease alpha to 
    # make hillshade more visible 
  ) +
  # Choose a continuous hypso palette for elevation.
  tidyterra::scale_fill_hypso_tint_c(
    palette = "dem_print",
    limits = limits) +
  # Add labels and theme
  labs(
    title = "Shaded Relief Map of Switzerland",
    fill = "Elevation (m)", # Legend title
    caption = paste(
      "Data: SRTM 30s via geodata.", 
      "Hillshade: Sun from West (270 deg)"
    )
  ) +
  # Use coord_sf to ensure correct aspect ratio for maps
  coord_sf(crs = terra::crs(swiss_elev_raster)) + # Use
  # raster's CRS
  theme_minimal() +
  theme(
    legend.position = "right", 
    axis.title = element_blank()
  )

# Step 3: Display the map
print(shaded_relief_map)
print("Shaded relief map generated.")