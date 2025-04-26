# --- Script: chapter_9_layers_control.R ---
# (Can be in same script)

# Step 1: Load packages and ensure data exists
pacman::p_load(leaflet, sf, tidyverse, giscoR, glue) # Need all previous pieces

# Step 2: Create map with multiple layers assigned to groups

print("Creating map with layers control...")
map_with_layers <- leaflet() |>
  # --- Base Map Layers ---
  # Add provider tiles one by one.
  # CRUCIAL: Assign each to a unique 'group' name.
  addProviderTiles(
    provider = providers$CartoDB.Positron, 
    group = "Simple Map") |>
  addProviderTiles(
    provider = providers$OpenStreetMap.Mapnik, 
    group = "OSM Map") |>
  addProviderTiles(
    provider = providers$Esri.WorldImagery, 
    group = "Satellite") |>
  
  # --- Overlay Data Layers ---
  # Add France polygon layer. Add data= here.
  # CRUCIAL: Assign it to an 'overlay group' name.
  addPolygons(
    data = france_sf,
    fillColor = "darkslateblue",
    color = "white",
    weight = 1.5,
    fillOpacity = 0.7,
    popup = ~ NAME_ENGL,
    group = "Countries"
  ) |> # Group name for this layer
  
  # Add City markers layer. Add data= here.
  # CRUCIAL: Assign it to an 'overlay group' name.
  addMarkers(
    data = cities_sf,
    popup = ~ glue::glue("<b>{name}</b><br/><i>{info}</i>"),
    group = "Cities"
  ) |> # Group name for this layer
  
  # --- Add Layers Control Widget ---
  # This function reads the 'group' names assigned above.
  addLayersControl(
    # List the names of the groups for the base maps (radio
    # buttons)
    baseGroups = c("Simple Map", "OSM Map", "Satellite"),
    # List the names of the groups for the overlay data
    # (checkboxes)
    overlayGroups = c("Cities", "Countries"),
    # Options for the control widget itself
    options = layersControlOptions(collapsed = FALSE) # Keep
    # expanded
  ) |>
  
  # Set initial view
  setView(lng = 2.3, lat = 46.8, zoom = 4) # Center near France

# Step 3: Display map
print("Displaying map with controls...")
print(map_with_layers)

# Store map object
assign("map_with_layers", map_with_layers, envir = .GlobalEnv)