# --- Script: chapter_9_project_landmarks.R ---

# Step 1: Setup
print("Loading packages for Landmark Exercise...")
pacman::p_load(leaflet, sf, tidyverse, glue, htmlwidgets)

# Step 2: Create Landmark Data
print("Creating landmark data...")
landmarks_df <- data.frame(
  landmark_name = c(
    "Eiffel Tower",
    "Statue of Liberty",
    "Taj Mahal",
    "Great Wall (Badaling)",
    "Machu Picchu",
    "Sydney Opera House"
  ),
  latitude = c(
    48.8584, 40.6892, 27.1751, 
    40.3540, -13.1631, -33.8568
  ),
  longitude = c(
    2.2945, -74.0445, 78.0421, 
    116.0005, -72.5450, 151.2153
  ),
  description = c(
    "Iconic tower in Paris, France.",
    "Symbol of freedom in New York Harbor, USA.",
    "Ivory-white marble mausoleum in Agra, India.",
    "Famous section of the Great Wall near Beijing, China.",
    "Incan citadel set high in the Andes Mountains, Peru.",
    "Multi-venue performing arts centre in Sydney, Australia."
  )
)

# Step 3: Convert to sf
print("Converting data to sf object...")
landmarks_sf <- sf::st_as_sf(
  landmarks_df,
  coords = c("longitude", "latitude"),
  crs = 4326)

# Step 4: Build Leaflet Map
print("Building interactive landmark map...")
landmark_map <- leaflet() |>
  # Base Maps
  addProviderTiles(
    provider = providers$OpenStreetMap.Mapnik, 
    group = "Street Map") |>
  addProviderTiles(
    provider = providers$Esri.WorldImagery, 
    group = "Satellite") |>
  # Landmark Markers
  addMarkers(
    data = landmarks_sf,
    popup = ~ glue::glue(
      "<b>{landmark_name}</b><br/>{description}"),
    group = "Landmarks"
  ) |>
  # Step 5: Add Controls
  addLayersControl(
    baseGroups = c("Street Map", "Satellite"),
    overlayGroups = c("Landmarks"),
    options = layersControlOptions(collapsed = FALSE)
  ) |>
  # Set View
  setView(lng = 10, lat = 30, zoom = 2) # Global view

# Step 6: Store & Display
print("Displaying landmark map...")
print(landmark_map)

# Step 7: Save Map
output_landmark_map <- "landmark_map.html"
print(paste("Saving map as:", output_landmark_map))
htmlwidgets::saveWidget(
  landmark_map, file = output_landmark_map, 
  selfcontained = TRUE
)
print("Landmark map saved.")