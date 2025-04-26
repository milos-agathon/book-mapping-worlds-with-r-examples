# --- Script: chapter_4_basic_choropleth.R ---

# Step 1: Load necessary packages
print("Loading packages...")
if (!requireNamespace("pacman", quietly = TRUE)) {
  install.packages("pacman")
}
pacman::p_load(tidyverse)
print("Packages ready.")

# Step 2: Load the cleaned and joined data
print("Loading cleaned spatial data...")
data_file <- "world_data_cleaned_joined.gpkg"
world_data_loaded <- sf::st_read(data_file)
print("Cleaned data loaded.")

# Step 3: Plot a basic choropleth
map_plot_basic <- ggplot2::ggplot(world_data_loaded) +
  ggplot2::geom_sf(
    mapping   = aes(fill = gdp_per_capita),
    color     = "white",
    linewidth = 0.1
  ) +
  ggplot2::labs(
    title    = "GDP per capita (2020)",
    fill     = "US Dollars"
  ) +
  ggplot2::theme_minimal()
# print("Map potentially saved.")

# Step 4: Render
print(map_plot_basic)