# --- Script: chapter_4_custom_colors.R ---

# Ensure required packages are installed and loaded
pacman::p_load(sf, ggplot2, scales)

# Create a choropleth using the Viridis 'rocket' palette with log10
# scaling
map_plot_viridis <- ggplot2::ggplot(data = world_data_loaded) +
  ggplot2::geom_sf(
    mapping = ggplot2::aes(fill = gdp_per_capita),
    color = "white",
    linewidth = 0.1
  ) +
  scale_fill_viridis_c(
    option = "rocket",
    direction = -1,
    name = "US dollars",
    na.value = "grey80",
    trans = "log10",
    # Use special labels for log scale
    # (requires scales package)
    labels = scales::label_log(digits = 2)
  ) +
  ggplot2::labs(title   = "GDP per capita") +
  ggplot2::theme_minimal() +
  ggplot2::theme(legend.position  = "bottom",
                 legend.key.width = grid::unit(1.5, "cm"))

# Display the map
print(map_plot_viridis)