# --- Script: chapter_9_add_polygons.R ---
# (Can be in same script)

# Step 1: Load packages & get boundary data
pacman::p_load(leaflet, sf, giscoR) # giscoR helps get boundaries

# Get boundary for France using giscoR
# giscoR usually returns data in EPSG:4326, which is good for
# leaflet.
print("Getting boundary for France...")

france_sf <- giscoR::gisco_get_countries(
  country = "FRA", resolution = "10")

print("Boundary obtained.")
assign(
  "france_sf", france_sf, envir = .GlobalEnv) # Store for later

# Step 2: Create map and add the polygon layer
print("Adding polygon layer...")
# Initialize leaflet, passing the france_sf data
map_with_polygon <- leaflet(data = france_sf) |>
  addProviderTiles(
    provider = providers$CartoDB.Positron) |>
  
  # Add polygons layer using addPolygons()
  addPolygons(
    # --- Styling Options ---
    fillColor = "darkslateblue",
    # Set the fill color
    color = "#FFFFFF",
    # Set the border color (white)
    weight = 1.5,
    # Set the border thickness (pixels)
    fillOpacity = 0.7,
    # Set fill transparency (0-1)
    
    # --- Popup Content ---
    # Use the NAME_ENGL column from the france_sf data 
    # for the popup
    popup = ~ NAME_ENGL
  ) |>
  
  # Set view centered on France
  setView(lng = 2.3, lat = 46.8, zoom = 5)

# Step 3: Display map
print("Displaying map with polygon...")
print(map_with_polygon)