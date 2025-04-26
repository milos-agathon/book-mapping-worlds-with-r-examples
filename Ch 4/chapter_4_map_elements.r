# --- Script: chapter_4_map_elements.R --- # (Can be in same script)

# Step 1: Load ggspatial and ensure data exists
pacman::p_load(ggspatial, tidyverse)

# Start with the previous map structure
map_plot_elements <- ggplot2::ggplot(data = world_data_loaded) +
  ggplot2::geom_sf(
    mapping = ggplot2::aes(fill = gdp_per_capita),
    color = "white",
    linewidth = 0.1
  ) +
  scale_fill_viridis_c(
    option = "rocket",
    # Choose a specific Viridis palette
    direction = -1,
    # reverse palette so that lighter colors are
    # associated with lower values, and darker with higher
    name = "US dollars",
    # legend title
    na.value = "grey80",
    # color for missing values
    trans = "log10",
    # Apply log10 transformation because density
    # is highly skewed (many low values, few very high values)
    # Use special labels for log scale
    # (requires scales package)
    labels = scales::label_log(digits = 2) # Use special labels for
    # log scale (requires scales package)
  ) +
  # *** ADD GGSPATIAL LAYERS ***
  # Add a scale bar
  # location="bl" (bottomleft), style="ticks"
  ggspatial::annotation_scale(
    location = "bl",
    width_hint = 0.3,
    style = "ticks") +
  # Add a north arrow
  # location="tr" (topright),
  # style=north_arrow_fancy_orienteering
  ggspatial::annotation_north_arrow(
    location = "tr",
    which_north = "true",
    pad_x = unit(0.1, "in"),
    pad_y = unit(1, "in"),
    style = ggspatial::north_arrow_fancy_orienteering
  ) +
  # Add labels and theme
  ggplot2::labs(title   = "GDP per capita") +
  # Use theme_void for cleaner look with scale bar/arrow
  theme_void() +
  theme(
    legend.position = "bottom",
    legend.key.width = unit(1.5, "cm"),
    plot.title = element_text(hjust = 0.5, face = "bold")
  ) # Center title

# Display the map
print("Displaying map with elements...")
print(map_plot_elements)

# Save the previous map
assign("plot_original", map_plot_viridis, envir = .GlobalEnv) 