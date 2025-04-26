# --- Script: chapter_5_dot_map.R ---
# (Can be in same script)

# Step 1: Ensure ggplot2 is loaded and data exists
pacman::p_load(tidyverse)

dot_map <- ggplot() +
  # Layer 1: World map background (light grey, white borders)
  geom_sf(
    data = world_map_background,
    fill = "grey80",
    color = "white",
    linewidth = 0.1
  ) +
  # Layer 2: City points
  # geom_sf automatically draws points because
  # cities_sf has POINT geometry
  geom_sf(
    data = cities_sf,
    color = "purple",
    # Set all points to blue
    size = 1,
    # Set point size
    shape = 16,
    # Use a solid circle shape
    # (default is often hollow)
    alpha = 0.6
  ) + # Add transparency for overplotting!
  
  # Add title and theme
  labs(title = "World Cities with Population > 1 Million") +
  theme_minimal() +
  theme(axis.text = element_blank()) # Hide axis labels

# Step 3: Display the map
print("Displaying dot map...")
print(dot_map)