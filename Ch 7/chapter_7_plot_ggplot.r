# --- Script: chapter_7_plot_ggplot.R ---
# (Can be in same script)

# Step 1: Ensure packages and data exist
# Need viridis for colors, part of tidyverse but good to ensure
pacman::p_load(terra, tidyverse)
# Step 2: Convert SpatRaster to data frame for ggplot2
# terra::as.data.frame() does the conversion.
# IMPORTANT: xy = TRUE includes the x (longitude) and y
# (latitude)
# coordinates for the center of each pixel! We need these for
# plotting.
print("Converting raster to data frame for ggplot2
      (can take time)...")
elevation_df <- terra::as.data.frame(
  global_elevation_10min, xy = TRUE
)
print("Conversion complete.")

# Step 3: Inspect the data frame structure
# See the new columns: x, y, and one with the raster
# layer's name.
print("--- First few rows of the data frame ---")
print(head(elevation_df))
print("--- Column names ---")
print(colnames(elevation_df)) # Note the 3rd column name!

# Step 4: Rename the value column for easier use in ggplot
# aes(). The value column name comes from the raster layer
# name (e.g., 'wc2.1_10m_elev')
# Let's find its name (it's usually the 3rd column after x
# and y) and rename it 'elevation'.
value_col_name <- names(elevation_df)[3]
print(paste("Renaming column:", value_col_name, "to 'elevation'"))

# Use the pipe |> with dplyr::rename()
elevation_df <- elevation_df |>
  # new_name = old_name. Use all_of() for safety if name has
  # spaces/symbols
  dplyr::rename(elevation = dplyr::all_of(value_col_name)) |>
  # Optional but recommended: Remove rows where elevation is NA
  # NA values can sometimes cause issues or appear as unwanted
  # colors
  dplyr::filter(!is.na(elevation))

print("Column renamed. New names:")
print(colnames(elevation_df))

# Step 5: Create the ggplot
print("Generating plot with ggplot2...")
# Start ggplot, providing the data frame
gg_elevation_map <- ggplot(data = elevation_df) +
  
  # Add the raster layer using geom_raster
  # aes() maps columns to visual properties:
  # x -> x-axis, y -> y-axis, elevation -> fill color
  geom_raster(aes(x = x, y = y, fill = elevation)) +
  
  # Apply a color scale suitable for continuous elevation data
  # scale_fill_viridis_c is perceptually uniform
  # 'option = "cividis"' is one specific viridis palette
  # 'name = ...' sets the legend title
  scale_fill_viridis_c(option = "turbo", name = "Elevation (m)") +
  
  # Add labels: title, axis labels, caption
  labs(
    title = "Global Elevation",
    x = "Longitude",
    y = "Latitude",
    caption = "Data source: WorldClim via geodata"
  ) +
  
  # Use coord_sf() to ensure ggplot uses an appropriate map
  # aspect ratio
  # It helps prevent the map from looking stretched or squashed.
  # crs = 4326 tells it the input coordinates are WGS84 Lat/Lon
  coord_sf(crs = 4326, expand = FALSE) + # expand=FALSE removes
  # padding
  
  # Apply theme adjustments for appearance
  theme_minimal() +
  theme(
    legend.position = "bottom", # Move legend below map
    legend.key.width = unit(1.5, "cm")
    ) # Make legend color bar wider

# Step 6: Display the ggplot map
# Printing the ggplot object renders it in the Plots pane.
print(gg_elevation_map)
print("ggplot map generated.")