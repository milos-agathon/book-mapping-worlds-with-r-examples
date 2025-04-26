# --- Script: chapter_9_add_markers.R --- 
# (Can be in same script)

# Step 1: Load packages if needed
pacman::p_load(leaflet, sf, tidyverse)

# Step 2: Create sample city data as an sf object
# We create a standard R data frame first.
city_data_df <- data.frame(
  name = c(
    "Amsterdam", "London", "Tokyo", "Nairobi", "Rio de Janeiro"
  ),
  latitude = c(52.37, 51.51, 35.68, -1.29, -22.91), # Latitudes
  longitude = c(4.89, -0.13, 139.69, 36.82, -43.17), # Longitudes
  info = c(
    "Canals & Culture", 
    "Big Ben & Buses",
    "Bustling Metropolis", 
    "Safari Gateway", 
    "Christ the Redeemer")
)

# Convert the data frame to an sf object using st_as_sf()
# Specify coordinate columns (longitude first!) and CRS (must be 
# 4326)
cities_sf <- sf::st_as_sf(
  city_data_df,
  coords = c("longitude", "latitude"),
  crs = 4326)
print("Sample city sf object created:")
print(cities_sf)
# Store for later
assign("cities_sf", cities_sf, envir = .GlobalEnv)

# Step 3: Create map and add markers
print("Adding markers to the map...")
# Initialize leaflet map, passing the sf object as the main data 
# source
# This makes the data available to layers added via the pipe |>
map_with_markers <- leaflet(data = cities_sf) |>
  addProviderTiles(
    provider = providers$CartoDB.Positron
  ) |> # Light base map
  
  # Add markers using addMarkers()
  # It automatically uses the geometry from the input data 
  # (cities_sf)
  addMarkers(
    # The 'popup' argument defines what shows when clicked.
    # Using the tilde '~' followed by a column name tells leaflet
    # to get the popup text FROM THAT COLUMN in the 'cities_sf' 
    # data.
    popup = ~name # Show the city 'name' column value in the popup
  ) |>
  
  # Set the initial map view to show the markers
  setView(lng = 30, lat = 20, zoom = 2) # Adjust view

# Step 4: Display map
print("Displaying map with markers...")
print(map_with_markers)