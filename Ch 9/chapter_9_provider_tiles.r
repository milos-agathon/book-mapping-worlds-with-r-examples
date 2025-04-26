# --- Script: chapter_9_provider_tiles.R --- 
# (Can be in same script)

# Step 1: Initialize leaflet map
print("Creating map with provider tiles...")
provider_map_light <- leaflet() |>
  # Step 2: Add a different provider tile layer using the pipe
  # We use addProviderTiles() and specify the provider name.
  # Examples: "CartoDB.Positron", "Esri.WorldImagery", "OpenTopoMap"
  # Find many more provider names here:
  # http://leaflet-extras.github.io/leaflet-providers/preview/
  # providers$CartoDB.Positron selects the specific tile set.
  addProviderTiles(
    provider = providers$CartoDB.Positron
  ) |> # Light grey map
  
  # Step 3: Optional: Set the initial view using setView()
  # setView(lng = longitude, lat = latitude, zoom = zoom_level)
  setView(lng = 0, lat = 30, zoom = 2) # Center roughly globally

# Step 4: Display map
print("Displaying light map...")
print(provider_map_light)

# --- Try another one! (Satellite imagery) ---
print("Creating map with satellite tiles...")
provider_map_sat <- leaflet() |>
  addProviderTiles(
    provider = providers$Esri.WorldImagery
  ) |> # Satellite
  setView(
    lng = 10, lat = 50, zoom = 4
  ) # Center roughly on Europe

print("Displaying satellite map...")
print(provider_map_sat)