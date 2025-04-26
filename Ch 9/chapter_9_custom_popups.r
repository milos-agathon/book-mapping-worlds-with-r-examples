# --- Script: chapter_9_custom_popups.R ---
# (Can be in same script)

# Step 1: Ensure packages and city data are ready
pacman::p_load(leaflet, sf, tidyverse, glue) # Need glue package

# Step 2: Create map with customized popups
print("Adding markers with custom HTML popups...")
map_custom_popups <- leaflet(data = cities_sf) |>
  addProviderTiles(provider = providers$CartoDB.Positron) |>
  addMarkers(
    # Create popup content using glue::glue() inside the ~
    # formula
    # glue() makes it easy to mix plain text and
    # {variable_names}
    # We include basic HTML tags: <b>...</b> for bold, <br/>
    # line break
    popup = ~ glue::glue(
      "<b>{name}</b><br/>", # City name in bold, then line break
      "<i>{info}</i>" # Info from the 'info' column in italics)
      )) |>
  setView(lng = 30, lat = 20, zoom = 2) # Set view
                         
# Step 3: Display map
print("Displaying map with custom popups...")
print(map_custom_popups)