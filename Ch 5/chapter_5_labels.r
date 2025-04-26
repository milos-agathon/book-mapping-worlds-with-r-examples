# --- Script: chapter_5_labels.R ---
# (Can be in same script)

# Step 1: Ensure packages and data exist
pacman::p_load(sf, tidyverse, ggrepel, rnaturalearth)
# Need 'cities_with_continent' from the spatial join step

namerica_cities_labeled <- cities_with_continent |>
  dplyr::filter(continent == "North America")

# Also get namerica boundaries for context
namerica_map_background <- rnaturalearth::ne_countries(
  scale = 'medium',
  continent = 'North America',
  returnclass = 'sf')

print(
  paste(
    "Labeling", 
    nrow(namerica_cities_labeled), "North American cities...")
)

# Step 3: Create map with repel labels
map_labels_namerica <- ggplot() +
  # Background map
  geom_sf(data = namerica_map_background,
          fill = "grey90",
          color = "white") +
  # City points (optional, can just have labels)
  geom_sf(data = namerica_cities_labeled,
          color = "navy",
          size = 1.5) +
  
  # *** ADD LABELS using geom_text_repel ***
  ggrepel::geom_text_repel(
    data = namerica_cities_labeled,
    # Map 'name.x' (city name from join) to the
    # label aesthetic
    aes(label = name.x, geometry = geometry),
    stat = "sf_coordinates",
    # Important for sf objects!
    # Tells repel how to get coords
    size = 2.5,
    # Font size
    min.segment.length = 0,
    # Draw line even if label
    # is close to point
    max.overlaps = 30,
    # Allow some overlap if needed,
    # increase if too sparse
    force = 0.5,
    # How strongly labels push away
    box.padding = 0.2 # Padding around text
  ) +
  
  # Add title and theme
  labs(title = "Major North American Cities (Labeled)") +
  theme_minimal() +
  theme(axis.title = element_blank())

# Step 4: Display map
print("Displaying map with labels...")
print(map_labels_namerica)