# --- Script: chapter_9_basic_map.R --- 
# (Can be in same script)

# Step 1: Initialize a leaflet map widget
# The leaflet() function creates the basic map container.
print("Creating basic leaflet map...")
basic_map <- leaflet() |>  # Start with leaflet()
  # Step 2: Add the default base map tiles (OpenStreetMap)
  # Use the pipe |> to send the map object to addTiles()
  addTiles() # This adds the standard OSM tile layer

# Step 3: Print the map object to display it
print("Displaying the map (check RStudio Viewer pane)...")
# In RStudio, this will show the map in the Viewer pane 
# (often near Plots)
# Outside RStudio (e.g., in R Markdown), it embeds the interactive 
# map.
print(basic_map)