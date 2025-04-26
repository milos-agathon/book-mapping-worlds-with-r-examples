# --- Script: chapter_6_project_rivers.R ---

# Step 1: Setup
print("Loading packages for Kolkata Rivers Exercise...")
pacman::p_load(sf, tidyverse, osmdata, ggspatial)

# Step 2: Get Boundary
bbox <- osmdata::getbb("Kolkata, India")
print("Bounding box obtained:")
print(bbox)

# Step 3: Get Line Data (OSM Rivers)
print("Getting OSM river data for Kolkata, India...")
osm_rivers_query <- osmdata::opq(
  bbox = bbox, timeout = 120) |> # Increase timeout
  osmdata::add_osm_feature(key = "waterway", value = "river") |>
  osmdata::osmdata_sf()

kolkata_rivers_sf <- osm_rivers_query$osm_lines

# Step 4: Clean Data
print("Cleaning river data...")
kolkata_rivers_sf_clean <- kolkata_rivers_sf |>
  dplyr::select(osm_id, name, waterway, geometry) |>
  dplyr::filter(!sf::st_is_empty(geometry))
print("Cleaning complete.")

# Step 5: Create Map
print("Creating map of kolkata rivers...")
kolkata_river_map <- ggplot() +
  # River lines
  geom_sf(data = kolkata_rivers_sf_clean,
          color = "steelblue",
          linewidth = 0.4) +
  # Labels
  labs(
    title = "Major Rivers in Kolkata, India", 
    caption = "Data: OpenStreetMap contributors") +
  # Optional scale bar
  ggspatial::annotation_scale(
    location = "bl",
    width_hint = 0.4,
    style = "ticks") +
  # Theme
  theme_void() +
  theme(plot.title = element_text(
    hjust = 0.5, face = "bold")
  )

print(kolkata_river_map)
print("Kolkata river map created.")

# Step 6: Optional Save
ggsave(
"kolkata_rivers.png", plot = kolkata_river_map, width = 6,
height = 8, dpi = 300, bg = "white")
# print("Map potentially saved.")
