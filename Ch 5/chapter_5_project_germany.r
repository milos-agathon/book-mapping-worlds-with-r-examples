# --- Script: chapter_5_project_germany.R ---

# Step 1: Setup
print("Loading packages for Germany Exercise...")
pacman::p_load(
  sf,               # For spatial data handling
  tidyverse,        # For data manipulation and plotting
  maps,             # Provides world.cities dataset
  rnaturalearth,    # Provides Natural Earth map data
  scales,           # Scale functions for legends
  ggrepel           # For non-overlapping text labels
)

# Step 2: Get Germany Boundary
print("Getting Germany boundary...")
germany_boundary_sf <- rnaturalearth::ne_countries(
  country     = "Germany",  # Only Germany
  scale       = "medium",   # Medium resolution
  returnclass = "sf"        # Return as sf object
)

# Step 3: Load & Prepare City Data
print("Loading and preparing German city data...")
german_cities_df <- maps::world.cities |>
  dplyr::filter(
    country.etc == "Germany",  # Only cities in Germany
    !is.na(pop)                # Exclude missing populations
  ) |>
  dplyr::select(
    name,  # City name
    pop,   # Population
    lat,   # Latitude
    long   # Longitude
  )

# Convert the data.frame to an sf object using the latitude/longitude columns
german_cities_sf <- sf::st_as_sf(
  german_cities_df,
  coords = c("long", "lat"),  # Columns to use for coordinates
  crs    = 4326               # WGS84 geographic coordinate system
)

print(paste("Loaded", nrow(german_cities_sf), "German cities with population data."))

# Step 4: Identify Top 5 Most Populous Cities
# ------------------------------------------
# Arrange cities by descending population and keep the first five
top5_cities_sf <- german_cities_sf |>
  dplyr::arrange(dplyr::desc(pop)) |>
  dplyr::slice(1:5) |>
  # Extract numeric X/Y coordinates for labeling
  dplyr::mutate(
    lon = sf::st_coordinates(geometry)[,1],
    lat = sf::st_coordinates(geometry)[,2]
  )

# Step 5: Create Bubble Map with Labels
print("Creating German city bubble map with top-5 labels...")
german_bubble_map <- ggplot2::ggplot() +
  # Background layer: Germany boundary
  ggplot2::geom_sf(
    data  = germany_boundary_sf,
    fill  = "grey95",
    color = "grey70"
  ) +
  # City points: size represents population
  ggplot2::geom_sf(
    data    = german_cities_sf,
    mapping = aes(size = pop),
    color   = "darkred",
    shape   = 16,
    alpha   = 0.6
  ) +
  # Label the top 5 largest cities
  ggrepel::geom_label_repel(
    data    = top5_cities_sf,
    mapping = aes(x = lon, y = lat, label = name),
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
  # Control the city bubble sizes and legend
  ggplot2::scale_size_area(
    name      = "Population",
    max_size  = 12,
    labels    = scales::label_number(scale = 1e-3, suffix = "K")
  ) +
  # Titles and caption
  ggplot2::labs(
    title   = "Major German Cities by Population",
    caption = "Data: maps::world.cities"
  ) +
  # Constrain the plot to Germany's bounding box
  # Clean theme
  ggplot2::theme_void()

# Step 6: Display the Map
print(german_bubble_map)
print("Germany map with top-5 labels created.")

# Step 7: Save the Map as image (optional)
# ggsave(
#   filename = "germany_major_cities.png", 
#   plot = german_bubble_map, device = "png",
#   width = 7, height = 8, bg = "white"
# )